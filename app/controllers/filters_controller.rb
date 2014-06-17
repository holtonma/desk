class FiltersController < ApplicationController
  respond_to :js, :html
  
  def index
    filter = Filter.all.first 
    redirect_to filter_cases_url({:filter_id => filter.id, :selected_filter_name => filter.name})
  end
  
end

