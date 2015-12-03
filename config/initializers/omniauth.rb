Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, ENV['fsq_client'], ENV['fsq_secret'], { 
    client_options: { ssl: { 
        ca_file: '/usr/lib/ssl/certs/ca-certificates.crt',
        ca_path: "/etc/ssl/certs"
    }}
  }
end