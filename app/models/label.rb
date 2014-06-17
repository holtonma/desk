class Label 
  include ActiveModel::Validations
  
  attr_reader   :id
  attr_accessor :name, :description, :color, :enabled, :types, :color
  
  TYPES = ['case', 'macro']
  COLOR_OPTIONS = [:default, :blue, :white, :yellow, :red, :orange, :green, :black, :purple, :brown, :grey, :pink]
  
  def initialize(options={})
    self.name        = options[:name]        || ''
    self.description = options[:description] || ''
    self.types       = options[:types]       || TYPES
    self.color       = options[:color]       || "default"
    self.enabled     = options[:enabled]     || true
  end
  
  
  # ----- facade around DESK API client -----
  def self.all
    Desk.labels
  end
  
  def self.all_label_names
    all.map{ |label| label.name }
  end
  
  def self.find(id)
    Desk.label(id)
  end
  
  def self.create!(options)
    attrs = {:name        => options[:name],
             :description => options[:description],
             :types       => options[:types],
             :enabled     => options[:enabled],
             :color       => options[:color]}
    
    Desk.create_label(attrs)
  end
    
end