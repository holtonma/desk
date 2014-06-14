
# Setup: Desk API requests pass through OAuth token-authenticated API client;
#        (configuration secrets not checked in, passed in through ENV)

Desk.configure do |config|
  config.support_email      = "holtonma@gmail.com"
  config.subdomain          = "redgrind"
  config.consumer_key       = ENV['DESK_KEY'] 
  config.consumer_secret    = ENV['DESK_SECRET']
  config.oauth_token        = ENV['DESK_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['DESK_OAUTH_TOKEN_SECRET']
end
