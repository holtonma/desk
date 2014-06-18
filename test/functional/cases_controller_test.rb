require 'test_helper'

class CasesControllerTest < ActionController::TestCase
  
  test "should route to case" do
    filter_id = 1234
    assert_routing "filters/#{filter_id}/cases", {:controller => "cases", :action => "index", :filter_id => "#{filter_id}"}
  end
  
  test "should get index" do
    filter_id = 1234
    setup_cases_mocks(filter_id)
    
    get :index, {:filter_id => filter_id}
    assert assigns(:filters)
    assert assigns(:desk_cases)
    assert_equal filter_id, assigns(:active_filter_id).to_i
    
    assert_equal 10, assigns(:filters).count, "known 'filters' fixture data should have 10 cases"
    assert_equal  5, assigns(:desk_cases).count, "know 'cases' fixture data should have 5 cases"
    assert_response :success
  end
  
  test "filter links should be present for each filter" do
    filter_id = 1234
    setup_cases_mocks(filter_id)
    get :index, {:filter_id => filter_id}
    
    assert_select 'div#filters', 1, "should only be one filters control container"
    assert_select 'div#filters' do
      assert_select "a.list-group-item", assigns(:filters).count, "As many filters links as filters should be present"
    end
  end
  
  test "filters should be decorated" do
    filter_id = 1234
    setup_cases_mocks(filter_id)
    
    get :index, {:filter_id => filter_id}
    assert assigns(:filters).decorated_with?(Draper::CollectionDecorator)
  end
  
  test "cases should be decorated" do
    filter_id = 1234
    setup_cases_mocks(filter_id)
    
    get :index, {:filter_id => filter_id}
    assert assigns(:desk_cases).decorated_with?(Draper::CollectionDecorator)
  end

  test "should get show" do 
    case_id = 1
    
    stub_get_request("labels",           "labels.json") # display labels in form
    stub_get_request("cases/#{case_id}", "case.json")   # display case to see what we're adding labels to
    
    get :show, {:filter_id => 1234, :id => 1, :labels => ["Escalated Example"]}
    assert_response :success
    assert_template :show
  end
  
  # exceptions 
  
  test "rescue from 404" do
    filter_id = 1234
    setup_response_code_mock(404)
    
    get :index, {:filter_id => filter_id}
    assert_template 'shared/remote_error'
    assert_match "not found", @response.body
  end
  
  test "rescue from 401 Unauthorized" do
    filter_id = 1234
    setup_response_code_mock(401)
    
    get :index, {:filter_id => filter_id}
    assert_template 'shared/remote_error'
    assert_match "Unauthorized", @response.body
  end
  
  test "rescue from 401 Bad Request" do
    filter_id = 1234
    setup_response_code_mock(400)
    
    get :index, {:filter_id => filter_id}
    assert_template 'shared/remote_error'
    assert_match "Bad Request", @response.body
  end
  
  test "rescue from 503 Service Unavailable" do
    filter_id = 1234
    setup_response_code_mock(503)
    
    get :index, {:filter_id => filter_id}
    assert_template 'shared/remote_error'
    assert_match "unavailable", @response.body
  end
  
  private
  
  def setup_cases_mocks(filter_id)
    stub_get_request("filters",                    "filters.json")
    stub_get_request("filters/#{filter_id}/cases", "cases.json")
  end
  
  def setup_response_code_mock(status, relative_endpoint="filters")
    stub_request(:get, "https://redgrind.desk.com/api/v2/#{relative_endpoint}").
      to_return(:status => status, :body => {}, :headers => {:content_type => "application/json; charset=utf-8"})
  end
  
end
