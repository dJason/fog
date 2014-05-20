require 'fog/core/collection'
require 'fog/centurylink/models/compute_v2/server'

module Fog
  module Compute
    class CenturyLinkV2

# TODO
      class Servers < Fog::Collection

        model Fog::Compute::CenturyLinkV2::Server

        def all(filters = {})
          data = service.get_all_servers.body['Servers']
          load(data)
        end

        def get(name)
          server = service.get_server(:name => name).body['Server']
          new(server) if server
        rescue Fog::Compute::CenturyLink::ResourceNotFound
          nil
        end

      end

    end
  end
end
