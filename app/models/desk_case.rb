class DeskCase 
  # 'case' entity for Desk  
  # (avoided ambiguity/collision of instances with reserved Ruby keyword, case)
  
  def self.all_matching(filter_id)
    Desk.filter_cases(filter_id)
  end
  
  def self.find(id) 
    Desk.case(id)
  end
  
end