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
  
  def stub_get_request(relative_endpoint, fixture_file)
    # build url +
    # by convention, use same name for fixture returning json
    stub_request(:get, "https://redgrind.desk.com/api/v2/#{relative_endpoint}").to_return(:status => 200, :body => fixture("#{fixture_file}"), 
                                                                             :headers => {:content_type => "application/json; charset=utf-8"})
    
  end

  def fixture_path
    File.expand_path("../fixtures", __FILE__)
  end

  def fixture(file)
    File.new(fixture_path + '/' + file)
  end
  
  
end
