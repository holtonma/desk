class LabelsController < ApplicationController
  
  def index
    prepare_form
    @label = Label.new
  end

  def create
    options  = params[:label_form].symbolize_keys
    @label   = Label.new(options)
    response = Label.create!(options) if @label.valid? # check if valid before going to remote 
    if @label.errors.count > 0 || (response.errors && response.errors.count > 0)
      flash[:alert] = "Label not created. #{error_output} #{remote_error_output(response)}"
      prepare_form
      @label = Label.new(options) # init with same posted data
      render :index
    else
      flash[:notice] = "Successfully created label: #{@label.name}"
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
  
  def error_output
    error_text = []
    @label.errors.each do |attribute, error|
      error_text << "*#{attribute}* #{error}"
    end
    error_text.join("; ").html_safe
  end
  
  def remote_error_output(response)
    error_text = ""
    if response && response.errors
      response.errors.to_hash.each do |k, v|
        error_text += "*#{k}* is "
        error_text += "#{v.join(' and ')}."
      end
    end
    
    error_text
  end
  
end
