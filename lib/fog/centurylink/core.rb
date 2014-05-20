require 'fog/core'

module Fog
  module CenturyLink
    extend Fog::Provider
    service(:compute,    'Compute')
    service(:compute_v2, 'Compute v2')
  end
end

