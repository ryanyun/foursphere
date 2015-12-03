Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, 'Z0T5FAZ3AMXDGEI3KKVBAPL1OXJS5OTCOXYAX51XJ1XT51KZ', ENV['fsq_secret'], { 
    client_options: { ssl: { 
        ca_file: '/usr/lib/ssl/certs/ca-certificates.crt',
        ca_path: "/etc/ssl/certs"
    }}
  }
end