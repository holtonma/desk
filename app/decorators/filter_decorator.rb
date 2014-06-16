class FilterDecorator < Draper::Decorator
  delegate_all
  
  def link_to_filter(active_filter_id=nil)
    helpers.link_to "#{filter.name}", helpers.filter_cases_path({:filter_id => filter.id, :selected_filter_name => filter.name}), 
                                                                {:class => "list-group-item #{active_class(active_filter_id)}"}
  end
  
  def active_class(active_filter_id)
    id == active_filter_id.to_i ? "active" : ""
  end

end
