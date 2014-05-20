module Fog
  module Compute
    class CenturyLinkV2
      class Real
        # Get server information
        #
        # {CenturyLink API Reference}[Undocumented]
        def get_server(servername)
          request(
            :expects  => 200,
            :method => 'GET',
            :resource => 'servers',
            :path => servername
          )
        end
      end
    end
  end
end