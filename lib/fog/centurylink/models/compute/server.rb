require 'fog/compute/models/server'

module Fog
  module Compute
    class CenturyLink

      class Server < Fog::Compute::Server
{"ID"=>1035, "HardwareGroupID"=>3157, "Location"=>"VA1",  "Name"=>"VA1LGSBR1XYZ01", "Description"=>"test-broker_30ea31xyz", "DnsName"=>"VA1LGSBR1XYZ01", "IsHyperscale"=>false, "IsTemplate"=>false, "Cpu"=>1, "MemoryGB"=>1, "DiskCount"=>3, "TotalDiskSpaceGB"=>16, "Status"=>"Active", "PowerState"=>"Started", "InMaintenanceMode"=>false, "IPAddress"=>"10.125.202.15", "ServerType"=>1, "ServiceLevel"=>2, "OperatingSystem"=>31, "DateModified"=>"/Date(1400537381357)/", "ModifiedBy"=>"ad9f36714fd44712b0f8d688eed01f81", "IPAddresses"=>[{"Address"=>"10.125.202.15", "AddressType"=>"RIP"}, {"Address"=>"206.128.152.74", "AddressType"=>"MIP"}], "CustomFields"=>nil}

        identity  :id
        attribute :hardware_group_id
        attribute :name
        attribute :description
        attribute :dns_name
        attribute :cpu
        attribute :memory_gb
        attribute :disk_count
        attribute :total_disk_space_gb
        attribute :is_template
        attribute :status
        attribute :server_type
        attribute :service_level
        attribute :operating_system
        attribute :power_state
        attribute :in_maintenance_mode
        attribute :ip_address
        attribute :ip_addresses
        attribute :custom_fields
        # Not documented but available
        attribute :location
        attribute :is_hyperscale
        attribute :date_modified

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

        def public_ip_addresses
          ip_addresses.reduce([]) {|set, ip| set << ip["Address"] if ip["AddressType"]=="RIP";set}
        end

        def public_ip_addresses
          ip_addresses.reduce([]) {|set, ip| set << ip["Address"] if ip["AddressType"]=="MIP";set}
        end

        def ready?
          status == 'Active'
        end

        def password
          compute.get_server_credentials(:name => server).body["Password"]
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
