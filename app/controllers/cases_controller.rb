class CasesController < ApplicationController
  respond_to :js, :html
  
  def index
    @filters            = FilterDecorator.decorate_collection(Filter.all)
    @active_filter_id   = params[:filter_id] || @filters.first.id
    @desk_cases         = CaseDecorator.decorate_collection(DeskCase.all_matching(@active_filter_id)) 
    @active_filter_name = params[:selected_filter_name] 
    
    respond_with([@filters, @desk_cases])
  end
  
  def show
    @desk_case   = DeskCase.find(params[:id])
    @label_names = LabelsDecorator.decorate_collection(Label.all)
    render :layout => false
  end
  
  def update
    new_label = params[:desk_case_form][:labels]
    case_id   = params[:id]
    DeskCase.append_case_label(case_id, new_label)
    
    flash[:notice] = "Successfully appended label!"
    redirect_to :action => 'index'    
  end
end

