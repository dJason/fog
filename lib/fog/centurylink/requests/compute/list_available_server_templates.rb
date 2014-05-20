module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets the list of Templates available to the account and location.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/23102683-List-Available-Server-Templates]
        def list_available_server_templates(options = {})
          data = {}
          data["Location"] = options[:location] if options[:location]
          data['AccountAlias'] = options[:account_alias] if options[:account_alias]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Server/ListAvailableServerTemplates/JSON'
          )
        end
      end
    end
  end
end