module Fog
  module Compute
    class CenturyLink
      class Real
        # Maps a public IP Address to a Server.
        #
        # {CenturyLink API Reference}[https://t3n.zendesk.com/entries/21271443-Add-Public-IP-Address]
        def add_public_ip_address(options)
          data = {}
          data['AccountAlias'] = options[:account_alias]
          data['ServerName'] = options[:name]
          data['IPAddress'] = options[:ip_address] if options[:ip_address]
          data['ServerPassword'] = options[:server_password] if options[:server_password]
          data['AllowHTTP'] = options[:allow_http] if options[:allow_http]
          data['AllowHTTPonPort8080'] = options[:allow_http_on_port_8080] if options[:allow_http_on_port_8080]
          data['AllowHTTPS'] = options[:allow_https] if options[:allow_https]
          data['AllowFTP'] = options[:allow_ftp] if options[:allow_ftp]
          data['AllowFTPS'] = options[:allow_ftps] if options[:allow_ftps]
          data['AllowSFTP'] = options[:allow_sftp] if options[:allow_sftp]
          data['AllowSSH'] = options[:allow_ssh] if options[:allow_ssh]
          data['AllowRDP'] = options[:allow_http] if options[:allow_hrpp]

          request(
            :body => Fog::JSON.encode(data),
            :path => 'Network/AddPublicIPAddress/JSON'
          )
        end
      end
    end
  end
end