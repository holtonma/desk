require 'test_helper'

class LabelDecoratorTest < Draper::TestCase
  
  test "should render panel heading" do
    assert_match /All Labels/, LabelDecorator.panel_heading
  end
  
  test "should render table header" do
    expected_headers = %w(Name Description Enabled Types Color)
    header_row = LabelDecorator.header_row
    assert header_row, "Should be present"
    
    expected_headers.each do |header|
      assert_match /#{header}/, header_row
    end
  end
  
  test "should render content row" do
    stub_get_request("labels", "labels.json")
    labels = LabelDecorator.decorate_collection(Label.all)
    
    label_row = labels.first
    rendered_row = label_row.render_row
    
    assert_match /#{label_row.name}/,        rendered_row
    assert_match /#{label_row.color}/,       rendered_row
    assert_match /#{label_row.description}/, rendered_row
    assert_match /#{label_row.enabled}/,     rendered_row
    
    # special cell -- make sure the types are there as expected
    label_row.types.each do |enabled_type|
      assert_match /#{enabled_type}/, rendered_row
    end
  end
  
  
end
