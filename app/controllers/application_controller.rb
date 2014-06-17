class ApplicationController < ActionController::Base
  rescue_from Desk::BadRequest,   :with => :render_400
  rescue_from Desk::Unauthorized, :with => :render_401
  rescue_from Desk::NotFound,     :with => :render_404
  
  protect_from_forgery
  
  private
  
  # trapping the basic cases here for now
  # arguably this helps the develper more than the customer :)
  # but provide some feedback to user if a resource was deleted
  def render_404
    render_error("The remote resource was not found")
  end
  
  def render_400
    render_error("Bad Request")
  end
  
  def render_401
    render_error("Unauthorized")
  end

  def render_error(message)
    render 'shared/remote_error', :locals => {:error_message => message} 
  end

end
