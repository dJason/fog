require 'fog/core/model'

module Fog
  module Compute
    class CenturyLink
      class Image < Fog::Model

        # TODO
        identity  :id
        attribute :name
        attribute :distribution

      end
    end
  end
end
