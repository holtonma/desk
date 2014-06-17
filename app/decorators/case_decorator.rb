class CaseDecorator < Draper::Decorator
  delegate_all
  
  def status_label_classes
    "label #{case_state_class}"
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
