class LabelsController < ApplicationController
  
  def index
    prepare_form
    @label = Label.new
  end

  def create
    options = params[:label_form].symbolize_keys
    label = Label.create!(options)
    
    if label.errors
      flash[:alert] = "Label not created. #{label.message}."
      prepare_form
      @label = Label.new(options)
      render :index
    else
      flash[:notice] = "Successfully created label: #{label.name}"
      redirect_to :action => 'index'
    end
    
  end
  
  private
  
  def prepare_form
    @labels = LabelDecorator.decorate_collection(Label.all)
    # for label form:
    @color_options = Label::COLOR_OPTIONS
    @type_options  = Label::TYPES
  end
  
end
