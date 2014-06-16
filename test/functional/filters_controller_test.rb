require 'test_helper'

class FiltersControllerTest < ActionController::TestCase

  test "should get index" do
    stub_get_request("filters", "filters.json")
    get :index
    assert assigns(:filters)
    assert_equal 10, assigns(:filters).count
    assert_response :success
  end
  
  test "filters should be decorated with Draper in html case" do
    stub_get_request("filters", "filters.json")
    get :index
    
    assert assigns(:filters).decorated_with?(Draper::CollectionDecorator)
  end
  
  private
  
end
