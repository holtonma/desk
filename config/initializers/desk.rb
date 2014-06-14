
# Setup: Desk API requests pass through OAuth token-authenticated API client;
#        (configuration secrets not checked in, passed in through ENV)

DeskApi.configure do |config|
  config.key                = ENV['DESK_KEY'] 
  config.secret             = ENV['DESK_SECRET']
  config.oauth_token        = ENV['DESK_OAUTH_TOKEN']
  config.oauth_token_secret = ENV['DESK_OAUTH_TOKEN_SECRET']
  config.site               = "https://redgrind.desk.com/api/v2"
  config.client             = DeskApi::Client.new
end
