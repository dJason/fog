module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets the credentials for the specified server.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21053657-Get-Server-Credentials]
        def get_server_credentials(options)
          data = {'Name' => options[:name] }
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Server/GetServerCredentials/JSON'
          )
        end
      end
    end
  end
end