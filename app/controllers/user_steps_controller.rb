class UserStepsController < ApplicationController
	include Wicked::Wizard
	#before_filter :authenticate_user!
	before_filter :check_signup

	steps :personal, :friends

	def show
	  @user = current_user
	  @users = @user.friends
      render_wizard
	end

	def update
		@user = current_user
		@user.attributes = params[:user]
		@user.update_attributes(params[:user])
		render_wizard @user
	end

	#Method that determines where the user will be sent after creating its profile
	def finish_wizard_path
    	#user_path(current_user)
    	root_url
  	end

	#Method that ensures user can get a role only 
	def check_signup
		@user = current_user
		if current_user.sign_in_count > 1
			redirect_to root_url
		end
	end
end