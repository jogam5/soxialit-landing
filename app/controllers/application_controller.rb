class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_uri

  def check_uri
    redirect_to request.protocol + "www." + request.host_with_port + request.request_uri if !/^www/.match(request.host)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), :alert => exception.message
	exception.default_message = "blage"
  end

end