require 'fog/centurylink/core'
require 'fog/compute'

module Fog
  module Compute
    class CenturyLinkV2 < Fog::Service

      requires     :centurylink_username
      requires     :centurylink_password

      recognizes   :centurylink_api_url
      recognizes   :centurylink_api_path

      model_path   'fog/centurylink/models/compute_v2'
      # TODO implement these
      model        :server
      collection   :servers
      model        :image
      collection   :images
      model        :region
      collection   :regions

      request_path 'fog/centurylink/requests/compute_v2'
      request      :get_public_ip
      request      :get_server
      request      :login
      request      :put_public_ip

#      request      :add_public_ip_address
#      request      :create_server
#      request      :delete_server
#      request      :get_all_servers
#      request      :get_deployable_networks
#      request      :get_deployment_status
#      request      :get_groups
#      request      :get_locations
#      request      :get_network_details
#      request      :get_server
#      request      :get_servers
#      request      :list_available_server_templates
#      request      :logon

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
          @centurylink_username = options[:centurylink_username]
          @centurylink_password = options[:centurylink_password]
          @centurylink_api_url  = options[:centurylink_api_url] || \
                                            "https://api.tier3.com"
          @centurylink_api_path = options[:centurylink_api_path] || "/v2"
          @connection           = Fog::Core::Connection.new(@centurylink_api_url)
        end

        def unauthenticated_request(params)
          do_request(params)
        end

        # If we get an Unauthorized error, we assume the token expired, re-auth and try again
        def request(params)
          unless @bearer_token
            do_login
          end
          begin
            do_request(params)
          rescue Excon::Errors::Unauthorized
            do_login
            do_request(params)
          end
        end

      private

        def do_login
          response = login(@centurylink_username, @centurylink_password)
          @bearer_token = response.body["bearerToken"]
          @account_alias = response.body["accountAlias"]
        end

        # Actually do the request
        def do_request(params)

          # Make the request, all requests use POST method and expect a 200 response code
          response = @connection.request({
            :body     => params[:body] || '',
            :expects  => params[:expects],
            :headers  => request_headers,
            :method   => params[:method],
            :path     => request_path(params[:resource], params[:path])
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

          response
        end

        def request_headers
          headers = { 'Content-Type' => 'application/json',
                      'Accept' => 'application/json' }
          headers.merge!({'Authorization' => "Bearer #{@bearer_token}"}) if @bearer_token
          headers
        end

        def request_path(resource, detail_path)
          path = "#{@centurylink_api_path}"
          path << "/#{resource}" if resource
          path << "/#{@account_alias}" if @account_alias
          path << "/#{detail_path}"
        end

      end
    end
  end
end
