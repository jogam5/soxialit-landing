class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :redirect_ssl

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), :alert => exception.message
	exception.default_message = "blage"
  end

  private 

  #only need this until Google doesn't link to HTTPS anymore
  def redirect_ssl
    if request.ssl?
      redirect_to "http://#{request.host_with_port}#{request.fullpath}", 
                  :status => :moved_permanently
    end
  end

end