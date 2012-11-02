class UserStepsController < ApplicationController
	include Wicked::Wizard
	before_filter :authenticate_user!
	#before_filter :check_signup

	steps :personal

	def show
		@user = current_user
		render_wizard
	end

	def update
		@user = current_user
		@user.attributes = params[:user]
		@user.update_attributes(params[:user])
		if @user.save
			render_wizard @user
		else
		 render 'personal'
		end
	end

	#Method that determines where the user will be sent after creating its profile
	def finish_wizard_path
    	user_path(current_user)
  	end

  	def unique_name
  		current_user.username
  	end

	#Method that ensures user can get a role only 
	#once (signing up)
	#def check_signup
	#	@user = current_user
	#	if current_user.roles.present?
	#		redirect_to root_url
	#	end
	#end
end