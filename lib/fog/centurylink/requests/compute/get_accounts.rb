module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets a deep list of all Servers for a given Hardware Group and its sub groups,
        # or all Servers for a given location.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21735513-Get-All-Servers]
        def get_accounts
          request(
            :path => 'Account/GetAccounts/JSON'
          )
        end
      end
    end
  end
end