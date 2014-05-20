module Fog
  module Compute
    class CenturyLinkV2
      class Real
        # Get public IP Address information
        #
        # {CenturyLink API Reference}[Undocumented]
        def get_public_ip(servername, ip)
          request(
            :expects  => 200,
            :method => 'GET',
            :resource => 'servers',
            :path => "#{servername}/publicIPAddresses/#{ip}"
          )
        end
      end
    end
  end
end