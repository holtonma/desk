class CasesController < ApplicationController
  
  respond_to :js, :html
  
  def index
    @filters            = FilterDecorator.decorate_collection(Filter.all)
    @active_filter_id   = params[:filter_id] || @filters.first.id
    @desk_cases         = CaseDecorator.decorate_collection(DeskCase.all_matching(@active_filter_id)) 
    
    respond_with([@filters, @desk_cases])
  end
  
  def show
    @existing_labels = params[:labels]
    @desk_case   = CaseDecorator.decorate(DeskCase.find(params[:id]))
    @label_names = Label.all.map{|l| l.name}
    render :layout => false
  end
  
  def update
    case_id   = params[:id]
    new_label = params[:new_label]
    DeskCase.append_case_label(case_id, new_label)
    
    flash[:notice] = "Successfully appended label '#{new_label}' to Case!"
    redirect_to :action => 'index'    
  end
  
  private
  

end

