module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets a list of all groups with the specified search criteria.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/20979826-Get-Groups]
        def get_groups(options)
          data = {}
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]
          data['Location'] = options[:location]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Group/GetGroups/JSON'
          )
        end
      end
    end
  end
end