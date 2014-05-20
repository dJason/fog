module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets list of all valid data center location codes.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/22422737-GetLocations]
        def get_locations
          request(
            :path => 'Account/GetLocations/JSON'
          )
        end
      end
    end
  end
end