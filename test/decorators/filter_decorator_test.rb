require 'test_helper'

class FilterDecoratorTest < Draper::TestCase

  test "filter link references filter_cases_path" do
    filter_id = 2013093 # known fixture data for single filter
    stub_get_request("filters/#{filter_id}", "filter.json")
    filter = Filter.find(filter_id)
    decorated_filter = FilterDecorator.new(filter)
    
    assert decorated_filter.methods.include?(:link_to_filter)
    assert_match /\/filters\/#{filter_id}\/cases/, decorated_filter.link_to_filter(42)
  end
  
  test "active class set when matching active_filter_id" do
    filter_id = 2013093 # known fixture data for single filter
    stub_get_request("filters/#{filter_id}", "filter.json")
    filter = Filter.find(filter_id)
    decorated_filter = FilterDecorator.new(filter)
    
    assert decorated_filter.decorated?
    assert_equal filter_id, decorated_filter.id
    assert_equal "active", decorated_filter.active_class(filter_id), "'active' class should be added when filter matches filter_id passed in"    
  end
  
  test "active class not set when matching active_filter_id" do
    filter_id = 2013093 # known fixture data for single filter
    stub_get_request("filters/#{filter_id}", "filter.json")
    filter = Filter.find(filter_id)
    decorated_filter = FilterDecorator.new(filter)
    
    assert decorated_filter.decorated?
    assert_equal filter_id, decorated_filter.id
    
    some_other_filter_id = 42
    assert_equal "", decorated_filter.active_class(some_other_filter_id), "No class should be added when filter not active" 
  end
  

  
end
