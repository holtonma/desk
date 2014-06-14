class Filter 
  
  def self.all
    Desk.filters
  end
  
  def self.find(id) # 2013093
    Desk.filter(id)
  end
  
end