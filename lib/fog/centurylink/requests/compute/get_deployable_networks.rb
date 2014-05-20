module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets the list of Networks mapped to an account in any Data Center that are deployable.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/23098157-Get-Deployable-Networks]
        def get_deployable_networks(options = {})
          data = {}
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]
          data['Location'] = options[:location] if options[:location]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Network/GetDeployableNetworks/JSON'
          )
        end
      end
    end
  end
end