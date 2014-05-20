module Fog
  module Compute
    class CenturyLink
      class Real
        # Creates a new Server.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21006677-Create-Server]
        def create_server(options)
          request(
            :body => Fog::JSON.encode(options),
            :path => 'Server/CreateServer/JSON'
          )
        end
      end
    end
  end
end