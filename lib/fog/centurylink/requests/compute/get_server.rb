module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets the detail for one server.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21741917-Get-Server]
        def get_server(options)
          data = {'Name' => options[:name] }
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Server/GetServer/JSON'
          )
        end
      end
    end
  end
end