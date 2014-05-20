module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets the list of Servers for a given Hardware Group (optional).
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21022593-Get-Servers]
        def get_servers(options = {})
          data = {}
          data['HardwareGroupID'] = options[:hardware_group] if options[:hardware_group]
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Server/GetServers/JSON'
          )
        end
      end
    end
  end
end