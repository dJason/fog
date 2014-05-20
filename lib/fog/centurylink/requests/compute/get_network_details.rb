module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets the details for a Network and its IP Addresses.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21726312-Get-Network-Details]
        def get_network_details(options)
          data = {}
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]
          data['Location'] = options[:location] if options[:location]
          data['Name'] = options[:name]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Network/GetNetworkDetails/JSON'
          )
        end
      end
    end
  end
end