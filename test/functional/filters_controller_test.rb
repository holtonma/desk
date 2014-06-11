require 'test_helper'

class FiltersControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end
  
end
