class AuthenticationsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    # Try to find authentication first
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
   
    if authentication
      # Authentication found, sign the user in.
      flash[:notice] = "Signed in successfully."
      sign_in(:user, authentication.user)
      #session[:user_id] = authentication.user.id
      redirect_to user_steps_path
      #redirect_to user_path(current_user)
    else
      # Authentication not found, thus a new user.
      user = User.new
      user.apply_omniauth(auth)
      if user.save(:validate => false)
        flash[:notice] = "Account created and signed in successfully."
        sign_in(:user, user)
        #session[:user_id] = user.id
        redirect_to user_steps_path
      else
        flash[:error] = "Error while creating a user account. Please try again."
        redirect_to root_url
      end
    end
  end
end