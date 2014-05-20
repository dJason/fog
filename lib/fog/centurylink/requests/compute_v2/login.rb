module Fog
  module Compute
    class CenturyLinkV2
      class Real
        # Acquires an authentication token used for subsequent queries to the API.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/31226990-Login]
        def login(username, password)
          data = {
            'username' => username,
            'password' => password
          }

          unauthenticated_request(
            :expects  => 200,
            :method => 'POST',
            :body => Fog::JSON.encode(data),
            :path => 'authentication/login'
          )
        end
      end
    end
  end
end