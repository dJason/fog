require 'fog/core/model'

module Fog
  module Compute
    class CenturyLinkV2
      class Region < Fog::Model

        # TODO
        identity  :id
        attribute :name

      end
    end
  end
end
