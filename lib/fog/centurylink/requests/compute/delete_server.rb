module Fog
  module Compute
    class CenturyLink
      class Real
        # Deletes the machine and releases all associated resources.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21016852-Delete-Server]
        def delete_server(options)
          data = {'Name' => options[:name] }
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Server/DeleteServer/JSON'
          )
        end
      end
    end
  end
end