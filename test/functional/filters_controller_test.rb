require 'test_helper'

class FiltersControllerTest < ActionController::TestCase
  
  test "should route to index action" do
    assert_routing "filters", {:controller => "filters", :action => "index"}
  end
  
  test "filters index should redirect" do
    stub_get_request("filters", "filters.json")
    
    get :index
    assert_response :redirect
  end
  
  
end
