class CasesController < ApplicationController
  respond_to :js, :html
  
  def index
    @active_filter_id   = params[:filter_id]
    @active_filter_name = params[:selected_filter_name]
    
    @filters    = FilterDecorator.decorate_collection(Filter.all)
    @desk_cases = CaseDecorator.decorate_collection(DeskCase.all_matching(@active_filter_id))
    
    respond_with([@filters, @desk_cases])
  end
  
end

