class CaseDecorator < Draper::Decorator
  delegate_all
  
  HEADERS = ["Status", "Subject", "Updated", "Labels", "Add Label"]
  
  def render_row
    h.content_tag(:tr, row_cells)  
  end
  
  def self.panel_heading
    h.content_tag(:div, :class => "panel-heading") do
      h.content_tag(:h4, "Cases Matching Filter")
    end.html_safe
  end
  
  def self.header_row
    h.content_tag(:tr, header_cells)
  end
  
  def status_label_classes
    "label #{case_state_class}"
  end
  
  def render_labels(labels)
    html_output = ""
    labels.each do |label|
      html_output += h.content_tag(:span, label, :class => "label_#{id} label label-default")
      html_output += "&nbsp;"
    end
    
    html_output.html_safe
  end
  
  private
  
  def self.header_cells
    cells = ""
    HEADERS.each do |header|
      cells += h.content_tag(:th, header)
    end
    
    cells.html_safe
  end
  
  def row_cells
    cells = ""
    cells += h.content_tag(:td, status_cell)
    cells += h.content_tag(:td, subject)
    cells += h.content_tag(:td, h.time_ago_in_words(updated_at) )
    cells += h.content_tag(:td, render_labels(labels))
    cells += h.content_tag(:td, add_label_cell, :nowrap=>true)
    
    cells.html_safe
  end
  
  def add_label_cell
    # for now, in onclick handler:
    h.link_to('Add Label', '#', :onclick => "Case.launchAddLabel(#{id})").html_safe
  end
  
  def status_cell
    h.content_tag(:span, status, :class => "#{status_label_classes}")
  end
  
  def case_state_class
    css_class = case object.status
      when "open"
        "label-info"
      when "new"
        "label-success"
      else
        "label-default"
    end
  end
end
