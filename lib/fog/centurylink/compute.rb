require 'fog/centurylink/core'
require 'fog/compute'

module Fog
  module Compute
    class CenturyLink < Fog::Service

      class UnknownError         < Fog::Compute::CenturyLink::Error; end
      class InvalidRequestFormat < Fog::Compute::CenturyLink::Error; end
      class ResourceNotFound     < Fog::Compute::CenturyLink::Error; end
      class InvalidOperation     < Fog::Compute::CenturyLink::Error; end
      class AuthenticationFailed < Fog::Compute::CenturyLink::Error; end
      class InvalidValue         < Fog::Compute::CenturyLink::Error; end
      class MissingRequiredValue < Fog::Compute::CenturyLink::Error; end
      class OutOfBounds          < Fog::Compute::CenturyLink::Error; end
      class InvalidPassword      < Fog::Compute::CenturyLink::Error; end

      requires     :centurylink_api_key
      requires     :centurylink_api_password

      recognizes   :centurylink_api_url
      recognizes   :centurylink_api_path

      model_path   'fog/centurylink/models/compute'
      model        :server
      collection   :servers


      # TODO implement these
      model        :image
      collection   :images
      model        :region
      collection   :regions

      request_path 'fog/centurylink/requests/compute'
      request      :add_public_ip_address
      request      :create_server
      request      :delete_server
      request      :get_accounts
      request      :get_all_servers
      request      :get_deployable_networks
      request      :get_deployment_status
      request      :get_groups
      request      :get_locations
      request      :get_network_details
      request      :get_server_credentials
      request      :get_server
      request      :get_servers
      request      :list_available_server_templates
      request      :logon

      class Mock
# TODO none of this is validated
        def self.data
          @data ||= Hash.new do |hash, key|
            hash[key] = {
              :servers => [],
              :ssh_keys => []
            }
          end
        end

        def self.reset
          @data = nil
        end

        def initialize(options={})
          @centurylink_api_key = options[:centurylink_api_key]
        end

        def data
          self.class.data[@centurylink_api_key]
        end

        def reset_data
          self.class.data.delete(@centurylink_api_key)
        end

      end

      class Real

        def initialize(options={})
          @centurylink_api_key      = options[:centurylink_api_key]
          @centurylink_api_password = options[:centurylink_api_password]
          @centurylink_api_url      = options[:centurylink_api_url] || \
                                            "https://api.tier3.com"
          @centurylink_api_path     = options[:centurylink_api_path] || "REST"
          @connection             = Fog::Core::Connection.new(@centurylink_api_url)
        end

        def unauthenticated_request(params)
          do_request(params)
        end

        # If we get an Unauthorized error, we assume the token expired, re-auth and try again
        def request(params)
          unless @cookie
            do_logon
          end
          begin
            do_request(params)
          rescue Fog::Compute::CenturyLink::AuthenticationFailed
            do_logon
            do_request(params)
          end
        end

      private

        def do_logon
          logon_results = logon(@centurylink_api_key, @centurylink_api_password)
          @cookie = logon_results.headers['Set-Cookie'] || logon_results.headers['set-cookie']
          accounts = get_accounts.body
          @account_alias = accounts["Accounts"].first["AccountAlias"]
        end

        # Actually do the request
        def do_request(params)

          # Make the request, all requests use POST method and expect a 200 response code
          response = @connection.request({
            :body     => params[:body] || '',
            :expects  => 200,
            :headers  => request_headers,
            :method   => 'POST',
            :path     => request_path(params[:path])
          })

          # Parse the response body
          if response &&
             response.body &&
             response.body.is_a?(String) &&
             !response.body.strip.empty?
            begin
              response.body = Fog::JSON.decode(response.body)
            rescue Fog::JSON::DecodeError => e
              Fog::Logger.warning("Error Parsing response json - #{e}")
              response.body = {}
            end
          end

          status_code = response.body["StatusCode"]
          message = response.body["Message"]
          case status_code.to_i
          when 2
            raise Fog::Compute::CenturyLink::UnknownError, message
          when 3
            raise Fog::Compute::CenturyLink::InvalidRequestFormat, message
          when 5
            raise Fog::Compute::CenturyLink::ResourceNotFound, message
          when 6
            raise Fog::Compute::CenturyLink::InvalidOperation, message
          when 100, 101
            raise Fog::Compute::CenturyLink::AuthenticationFailed, message
          when 500, 501, 1000
            raise Fog::Compute::CenturyLink::InvalidValue, message
          when 502, 506, 514, 541, 1310, 1410, 1510
            raise Fog::Compute::CenturyLink::MissingRequiredValue, message
          when 503, 1413
            raise Fog::Compute::CenturyLink::OutOfBounds, message
          when 1414
            raise Fog::Compute::CenturyLink::InvalidPassword, message
          end

          response
        end

        def request_headers
          headers = { 'Content-Type' => 'application/json; charset=utf-8',
            'Accept' => 'application/json'
          }
          headers.merge!({'Cookie' => @cookie}) if @cookie
          headers
        end

        def request_path(path)
          "#{@centurylink_api_path}/#{path}"
        end

      end
    end
  end
end
