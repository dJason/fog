require 'fog/core/model'

module Fog
  module Compute
    class CenturyLink
      class Region < Fog::Model

        # TODO
        identity  :id
        attribute :name

      end
    end
  end
end
