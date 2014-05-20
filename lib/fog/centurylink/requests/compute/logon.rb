module Fog
  module Compute
    class CenturyLink
      class Real
        # Logon method, required to be called prior to other methods.
        # Returns a cookie to be sent on all subsequent requests.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/20339862-Logon]
        def logon(apikey, password)
          data = {
            'APIKey' => apikey,
            'Password' => password
          }

          unauthenticated_request(
            :body => Fog::JSON.encode(data),
            :path => 'Auth/logon'
          )
        end
      end
    end
  end
end