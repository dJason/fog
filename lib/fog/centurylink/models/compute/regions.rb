require 'fog/core/collection'
require 'fog/centurylink/models/compute/region'

module Fog
  module Compute
    class CenturyLink

      class Regions < Fog::Collection
        model Fog::Compute::CenturyLink::Region

# TODO
        def all
          load service.list_regions.body['regions']
        end

        def get(id)
          all.find { |f| f.id == id }
        rescue Fog::Errors::NotFound
          nil
        end

      end

    end
  end
end
