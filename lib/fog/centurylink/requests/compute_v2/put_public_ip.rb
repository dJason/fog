module Fog
  module Compute
    class CenturyLinkV2
      class Real
        # Update information for a public IP address
        #
        # {CenturyLink API Reference}[Undocumented]
        def put_public_ip(servername, ip, data)
          request(
            :expects  => [200, 201, 202],
            :method => 'PUT',
            :resource => 'servers',
            :body => Fog::JSON.encode(data),
            :path => "#{servername}/publicIPAddresses/#{ip}"
          )
        end
      end
    end
  end
end