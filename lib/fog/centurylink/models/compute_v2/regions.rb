require 'fog/core/collection'
require 'fog/centurylink/models/compute_v2/region'

module Fog
  module Compute
    class CenturyLinkV2

      class Regions < Fog::Collection
        model Fog::Compute::CenturyLinkV2::Region

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
