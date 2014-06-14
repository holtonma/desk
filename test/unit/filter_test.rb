require 'test_helper'

class FilterTest < ActiveSupport::TestCase
  
  test "all filters should return array of filters" do
    stub_get_request("filters", "filters.json")
    filters = Filter.all
    assert_equal 10, filters.count, "Expected 10 filters in known fixture data"
    assert filters.is_a?(Hashie::Deash)
    assert filters.first.is_a?(Hashie::Deash)
  end
  
  test "find filter should return a single filter" do
    filter_id = 2013093
    stub_get_request("filters/#{filter_id}", "filter.json")
    
    filter    = Filter.find(filter_id)
    assert filter.is_a?(Hashie::Deash)
    assert_equal "Inbox", filter.name
  end
  
end
