module Fog
  module Compute
    class CenturyLinkV2
      class Real
        # Get status on a queued operation
        #
        # {CenturyLink API Reference}[Undocumented]
        def get_operations_status(location, request_id)
          request(
            :expects  => 200,
            :method => 'GET',
            :resource => 'operations',
            :path => 'status/#{location}-#{request_id}'
          )
        end
      end
    end
  end
end