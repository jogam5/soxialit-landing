class ApplicationController < ActionController::Base
  before_filter :check_url
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user), :alert => exception.message
	exception.default_message = "blage"
  end

  def check_url
	  url = request.url
	  if url.include?('soxialit.herokuapp.com')
	    redirect_to ('http://www.soxialit.com')
	  elsif url.include?('soxialit.com')
	    redirect_to ('http://www.soxialit.com')       
	  end    
  end
end
