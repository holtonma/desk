class Filter 
  
  def self.all
    Desk.filters
  end
  
  def self.find(id)
    Desk.filter(id)
  end
  
end