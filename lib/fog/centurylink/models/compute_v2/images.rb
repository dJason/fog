require 'fog/core/collection'
require 'fog/centurylink/models/compute_v2/image'

module Fog
  module Compute
    class CenturyLinkV2

      class Images < Fog::Collection
        model Fog::Compute::CenturyLinkV2::Image

# TODO
        def all
          load service.list_images.body['images']
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
