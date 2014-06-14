class FiltersController < ApplicationController
  respond_to :js, :html
  
  def index
    @filters = FilterDecorator.decorate_collection(Filter.all) # remote call
    respond_with(@filters)
  end
  
end

