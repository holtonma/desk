require 'test_helper'

class CaseDecoratorTest < Draper::TestCase
  
  test "header labels" do
    assert_equal expected_case_headers, CaseDecorator::HEADERS
  end
  
  test "should render table header" do
    header_row = CaseDecorator.header_row
    assert header_row, "Should be present"
    
    expected_case_headers.each do |header|
      assert_match /#{header}/, header_row
    end
  end
  
  test "should render content row" do
    filter_id = 1234
    stub_get_request("filters/#{filter_id}/cases", "cases.json")
    desk_cases = CaseDecorator.decorate_collection(DeskCase.all_matching(filter_id))
    case_row = desk_cases.first
    
    rendered_row = case_row.render_row
    
    assert_match /#{case_row.status}/,  rendered_row
    assert_match /#{case_row.subject}/, rendered_row
    assert_match /Add Label/,           rendered_row
    
    # special cell -- make sure the types are there as expected
    case_row.labels.each do |label|
      assert_match /#{label}/, rendered_row
    end
  end
  
  test "should set the proper classes for status labels" do
    case_id = 1 # known fixture data single case
    stub_get_request("cases/#{case_id}", "case.json")
    desk_case = DeskCase.find(case_id)
    decorated_case = CaseDecorator.new(desk_case)
    
    assert decorated_case.decorated?
    assert_equal case_id, decorated_case.id
    assert_equal "open", desk_case.status
    assert_equal "label label-info", decorated_case.status_label_classes    
  end
  
  private
  
  def expected_case_headers
    ["Status", "Subject", "Updated", "Labels", "Add Label"]
  end
  
  
end
