ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'webmock/test_unit'
WebMock.disable_net_connect!(allow_localhost: true)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def configure_desk_api_env_and_client
    ENV['DESK_KEY']                = sample_key
    ENV['DESK_SECRET']             = sample_secret
    ENV['DESK_OAUTH_TOKEN']        = sample_oauth_token
    ENV['DESK_OAUTH_TOKEN_SECRET'] = sample_oauth_token_secret

    DeskApi.configure do |config|
      config.key                = ENV['DESK_KEY'] 
      config.secret             = ENV['DESK_SECRET']
      config.oauth_token        = ENV['DESK_OAUTH_TOKEN']
      config.oauth_token_secret = ENV['DESK_OAUTH_TOKEN_SECRET']
      config.site               = sample_site
      config.client             = DeskApi::Client.new
    end
  end
  
  def sample_key
    "test_key"
  end
  
  def sample_secret
    "test_secret"
  end
  
  def sample_oauth_token
    "test_oauth_token"
  end
  
  def sample_oauth_token_secret
    "test_oauth_token_secret"
  end
  
  def sample_site
    "https://redgrind.desk.com/api/v2"
  end
  
  def stubbed_header_auth
    "OAuth oauth_consumer_key='#{sample_key}', 
           oauth_nonce='BBb9VxFROHUTY5ICqiKEZKecsU9Yec6bM3zbDfocUls', 
           oauth_signature='oXUtNILyfqROwU1yI3q577OGEyY%3D', oauth_signature_method='HMAC-SHA1', 
           oauth_timestamp='#{Time.now.to_i}', oauth_token='#{sample_oauth_token}', oauth_version='1.0', 
           'User-Agent'=>'OAuth gem v0.4.7'"
    
  end
  
end
