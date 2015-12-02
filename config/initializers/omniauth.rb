Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, ENV['fsq_client'], ENV['fsq_secret']
end