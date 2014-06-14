require 'test_helper'

class DeskApiClientTest < ActiveSupport::TestCase
  
  def setup
    configure_desk_api_env_and_client
  end
  
  test "config should set oauth attributes from environment" do
    # used in initializers/desk.rb:
    assert_equal sample_key,                DeskApi.key
    assert_equal sample_secret,             DeskApi.secret
    assert_equal sample_oauth_token,        DeskApi.oauth_token
    assert_equal sample_oauth_token_secret, DeskApi.oauth_token_secret
  end
  
  test "config should set site URL if specified" do
    assert_equal sample_site, DeskApi.site
  end
  
  test "config should instantiate a Client instance" do
    assert DeskApi.client.is_a?(DeskApi::Client)
  end
  
  test "get request should use site url as root" do
    client   = DeskApi.client
    resource = "filters"
    req_path = "/#{resource}"
    
    # set up expectations
    json_data = stubbed_json_for(resource)
    stub_request(:get, "#{DeskApi.site}#{req_path}").to_return(:status => 200, :body => json_data, :headers => {})
    
    # make the request, look at response
    json_response = client.get("/filters").body
    response_hash = JSON.parse(json_response)
    assert_equal String, json_response.class,                    "Expected returned JSON to be a String"
    assert_equal 10, response_hash["total_entries"],             "expected 10 entries in known fixture "
  end
  
  test "reading stubbed data from fixture" do
    client   = DeskApi.client
    resource = "filters"
    req_path = "/#{resource}"
    
    # expectations
    json_data = stubbed_json_for(resource)
    stub_request(:get, "#{DeskApi.site}#{req_path}").to_return(:status => 200, :body => json_data, :headers => {})
    
    # make the request
    json_response = client.get("/filters").body
    response_hash = JSON.parse(json_response)
    
    # sanity check on some of the data
    entries =  response_hash["_embedded"]["entries"]
    assert_equal response_hash["total_entries"], entries.length, "expected count of entries to be equal to total_entries"
    assert_equal "Inbox", entries.first["name"],                 "expected first entry to be 'Inbox'"
  end
  
  test "valid and allowed HTTP request methods" do
    valid_methods = DeskApi::Client::VALID_REQUEST_METHODS
    assert_equal 7, valid_methods.length
    assert valid_methods.include?('get')
    assert valid_methods.include?('post')
    assert valid_methods.include?('patch')
    assert valid_methods.include?('put')
    assert valid_methods.include?('delete')
    assert valid_methods.include?('head')
    assert valid_methods.include?('request')
  end
  
  test "invalid HTTP request method raises" do
    assert_equal false, DeskApi::Client::VALID_REQUEST_METHODS.include?("bogus_method")
    assert_raise NoMethodError, "Expected exception when the client uses an unsupported method" do
      DeskApi.client.bogus_method("/filters", {})
    end
  end
  
  
  private
  
  def stubbed_json_for(resource)
    # read in fixture data (Ruby hash), output 
    fixture = File.read(File.dirname(__FILE__) + "/../fixtures/#{resource}.json")
  end
  
  
end
