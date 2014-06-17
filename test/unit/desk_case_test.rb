require 'test_helper'

class DeskCaseTest < ActiveSupport::TestCase
  
  test "DeskCase.all_matching should return array of cases matching filter_id" do
    filter_id = 2013094
    stub_get_request("filters/#{filter_id}/cases", "cases.json")
    desk_cases = DeskCase.all_matching(filter_id)
    assert_equal 5, desk_cases.count, "Expected 5 filters in known fixture data for filtered cases"
    assert desk_cases.is_a?(Hashie::Deash)
    assert desk_cases.first.is_a?(Hashie::Deash)
  end
  
  test "DeskCase.find should return a single desk_case" do
    case_id = 1
    stub_get_request("cases/#{case_id}", "case.json")
    
    desk_case = DeskCase.find(case_id)
    assert desk_case.is_a?(Hashie::Deash)
    assert_equal "Getting Started with Your New Account", desk_case.subject
  end
  
  test "DeskCase.append_case_label should send an update case request" do
    label_to_append = "Example"
    
    case_id = 1
    stub_get_request("cases/#{case_id}", "case.json")
    
    desk_case = DeskCase.find(case_id)
    assert_equal false, desk_case[:raw][:labels].include?(label_to_append), "Preconditions: label shouldn't already be attached to case"
    
    setup_update_request("cases/#{case_id}", "update_case_labels.json")
    DeskCase.append_case_label(case_id, label_to_append)
  end
  
  
  private
  
  def setup_update_request(relative_endpoint, fixture_file)
    stub_request(:patch, "https://redgrind.desk.com/api/v2/#{relative_endpoint}").to_return(:status => 200, :body => fixture("#{fixture_file}"), 
                                                                                            :headers => {:content_type => "application/json; charset=utf-8"})
  end
  
end
