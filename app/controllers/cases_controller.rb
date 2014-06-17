class CasesController < ApplicationController
  respond_to :js, :html
  
  def index
    @filters            = FilterDecorator.decorate_collection(Filter.all)
    @active_filter_id   = params[:filter_id] || @filters.first.id
    @desk_cases         = CaseDecorator.decorate_collection(DeskCase.all_matching(@active_filter_id)) 
    @active_filter_name = params[:selected_filter_name] 
    
    respond_with([@filters, @desk_cases])
  end
  
end

