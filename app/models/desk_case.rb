class DeskCase 
  # 'case' entity for Desk  
  # (avoided ambiguity/collision of instances with reserved Ruby keyword, case)
  
  def self.all_matching(filter_id)
    Desk.filter_cases(filter_id)
  end
  
  def self.find(id) 
    Desk.case(id)
  end
  
  def self.append_case_label(case_id, label_name)
    Desk.update_case(case_id.to_i, :labels => [label_name.to_s])
  end
  
end