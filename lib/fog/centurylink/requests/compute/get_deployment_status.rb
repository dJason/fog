module Fog
  module Compute
    class CenturyLink
      class Real
        # Gets the status of the specified Blueprint deployment.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/20561586-Get-Deployment-Status]
        def get_deployment_status(options)
          data = { 'RequestID' => options[:request_id] }
          data['LocationAlias'] = options[:location] if options[:location]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Blueprint/GetBlueprintStatus/JSON'
          )
        end
      end
    end
  end
end