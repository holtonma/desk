require 'test_helper'

class CaseDecoratorTest < Draper::TestCase
  
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
  
  
end
