class LabelDecorator < Draper::Decorator
  delegate_all
  
  HEADERS = %w(Name Description Enabled Types Color)
  
  def self.panel_heading
    h.content_tag(:div, :class => "panel-heading") do
      h.content_tag(:h4, "All Labels")
    end.html_safe
  end
  
  def render_row
    h.content_tag(:tr, row_cells)  
  end
  
  def self.header_row
    h.content_tag(:tr, header_cells)
  end
  
  private
  
  def row_cells
    cells = ""
    cells += h.content_tag(:td, name)
    cells += h.content_tag(:td, description)
    cells += h.content_tag(:td, enabled)
    cells += h.content_tag(:td, enabled_types_cell)
    cells += h.content_tag(:td, color)
    
    cells.html_safe
  end
  
  def self.header_cells
    cells = ""
    HEADERS.each do |header|
      cells += h.content_tag(:th, header)
    end
    
    cells.html_safe
  end
  
  def enabled_types_cell
    html_output = ""
    types.map do |t|
      html_output += h.content_tag(:span, t, :class => "label #{type_class(t)}")
      html_output += "&nbsp;"
    end
    
    html_output.html_safe
  end
  
  def type_class(enabled_type)
    "label-default #{macro_class(enabled_type)}"
  end
  
  def macro_class(enabled_type)
    "macro" == enabled_type ? "label-info" : ""
  end
  
end
