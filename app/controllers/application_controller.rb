class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :initialize_mixpanel

	def initialize_mixpanel
	  if defined?(MIXPANEL_TOKEN)
	    @mixpanel = Mixpanel.new(MIXPANEL_TOKEN, request.env)
	  else
	    @mixpanel = DummyMixpanel.new
	  end
	end
end
