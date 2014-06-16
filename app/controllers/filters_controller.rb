class FiltersController < ApplicationController
  respond_to :js, :html
  
  def index
    @filters = FilterDecorator.decorate_collection(Filter.all) # remote call
    
    respond_with(@filters)
  end
  
  def show
    @filter = Filter.find(params[:id].to_i)
    FilterDecorator.decorate(@filter)
    
    respond_with(@filter)
  end
  
end

