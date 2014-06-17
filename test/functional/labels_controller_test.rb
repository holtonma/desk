require 'test_helper'

class LabelsControllerTest < ActionController::TestCase
  test "should route to label" do
    assert_routing "labels", {:controller => "labels", :action => "index"}
  end

  test "should get index with list of labels" do
    setup_labels_mocks
    get :index
    
    assert_response :success
    assert assigns(:labels)
    assert_equal 8, assigns(:labels).count, "known 'labels' fixture data should have N labels"
  end
  
  test "labels should be decorated" do
    setup_labels_mocks
    get :index
    
    assert_response :success
    assert assigns(:labels).decorated_with?(Draper::CollectionDecorator)
  end
  
  test "index should set up instance variables for Create New Label form with default options" do
    setup_labels_mocks
    get :index
    
    assert_equal Label::COLOR_OPTIONS, assigns(:color_options)
    assert_equal Label::TYPES,         assigns(:type_options)   
    
    assert_equal '',                assigns(:label).name
    assert_equal '',                assigns(:label).description
    assert_equal true,              assigns(:label).enabled
    assert_equal ['case', 'macro'], assigns(:label).types
    assert_equal 'default',         assigns(:label).color
  end
  

  test "successful post to create should redirect" do
    setup_create_request("labels", "create_label_success_response.json")
    post :create, {"label_form"=>{"name"=>"new label", "description"=>"asdf", "color"=>"white", "enabled"=>"1", "types"=>["case", "macro", ""]}}
    
    assert_response :redirect
  end

  test "failed post to create should render with flash" do
    setup_create_request("labels", "create_label_fail_response.json")
    setup_labels_mocks
    
    post :create, {"label_form"=>{"name"=>"", "description"=>"asdf", "color"=>"white", "enabled"=>"1", "types"=>["case", "macro", ""]}}
    assert flash[:alert]
    puts flash[:alert]
    assert_template :index
  end
  
  private
  
  def setup_labels_mocks
    stub_get_request("labels", "labels.json")
  end
  
  def setup_create_request(relative_endpoint, fixture_file)
    stub_request(:post, "https://redgrind.desk.com/api/v2/#{relative_endpoint}").to_return(:status => 200, :body => fixture("#{fixture_file}"), 
                                                                             :headers => {:content_type => "application/json; charset=utf-8"})
  end
  
  
end
