module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets a deep list of all Servers for a given Hardware Group and its sub groups,
        # or all Servers for a given location.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21735513-Get-All-Servers]
        def get_all_servers(options = {})
          data = {}
          data['HardwareGroupID'] = options[:hardware_group_id] || "0"
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]
          data['Location'] = options[:location] if options[:location]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Server/GetAllServers/JSON'
          )
        end
      end
    end
  end
end