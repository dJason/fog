require 'fog/compute/models/server'

module Fog
  module Compute
    class CenturyLink

      class Server < Fog::Compute::Server

        identity  :id,                  :aliases => 'ID',                :type => :integer
        attribute :hardware_group_id,   :aliases => 'HardwareGroupID',   :type => :integer
        attribute :name,                :aliases => 'Name'
        attribute :description,         :aliases => 'Description'
        attribute :dns_name,            :aliases => 'DnsName'
        attribute :cpu,                 :aliases => 'Cpu',               :type => :integer
        attribute :memory_gb,           :aliases => 'MemoryGB',          :type => :integer
        attribute :disk_count,          :aliases => 'DiskCount',         :type => :integer
        attribute :total_disk_space_gb, :aliases => 'TotalDiskSpaceGB',  :type => :integer
        attribute :is_template,         :aliases => 'IsTemplate',        :type => :boolean
        attribute :status,              :aliases => 'Status'
        attribute :server_type,         :aliases => 'ServerType'
        attribute :service_level,       :aliases => 'ServiceLevel'
        attribute :operating_system,    :aliases => 'OperatingSystem',   :type => :integer
        attribute :power_state,         :aliases => 'PowerState',        :type => :integer
        attribute :in_maintenance_mode, :aliases => 'InMaintenanceMode', :type => :boolean
        attribute :ip_address,          :aliases => 'IPAddress'
        attribute :ip_addresses,        :aliases => 'IPAddresses'
        attribute :custom_fields,       :aliases => 'CustomFields'
        # Not documented but available
        attribute :location,            :aliases => 'Location'
        attribute :is_hyperscale,       :aliases => 'IsHyperscale',      :type => :boolean
        attribute :date_modified,       :aliases => 'DateModified'
        #
        attribute :password

        def initialize(attributes={})
          cpu ||= 1
          memory_gb ||= 1
          operating_system ||= 31 # Ubuntu 12 64-Bit
          super
        end

        def destroy
          requires :name
          service.delete_server(:name => name)
          true
        end

        def private_ip_address
          ip_address
        end

        def private_ip_addresses
          ip_addresses.reduce([]) {|set, ip| set << ip["Address"] if ip["AddressType"]=="RIP";set}
        end

        def public_ip_addresses
          ip_addresses.reduce([]) {|set, ip| set << ip["Address"] if ip["AddressType"]=="MIP";set}
        end

        def ready?
          status == 'Active'
        end

        def get_password
          password = service.get_server_credentials(:Name => server).body["Password"]
        end

        def reboot(type = 'SOFT')
          # TODO
          true
        end

        def save(options = {})
          # TODO
          true
        end

      end

    end
  end

end
