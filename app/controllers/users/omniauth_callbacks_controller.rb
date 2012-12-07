class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		auth = request.env["omniauth.auth"]
    # You need to implement the method below in your model (e.g. app/models/user.rb)
      	@user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

	    if @user.persisted?
	      sign_in(:user, @user)
	      redirect_to user_steps_path
	      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
	    else
	      session["devise.facebook_data"] = request.env["omniauth.auth"]
	      redirect_to root_url
	    end
  	end
end