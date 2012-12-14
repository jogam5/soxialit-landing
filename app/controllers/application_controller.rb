class ApplicationController < ActionController::Base
  protect_from_forgery

  Rails.env.production? do
    before_filter :check_url
  end

  def check_url
    redirect_to request.protocol + "www." + request.host_with_port + request.fullpath if !/^www/.match(request.host)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), :alert => exception.message
	exception.default_message = "blage"
  end
end