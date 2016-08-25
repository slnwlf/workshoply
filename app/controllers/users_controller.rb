class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
		@user = user
	end

	def update
		if user_params
			user.update_attributes(user_params)
			flash[:notice] = "Successfully update profile picture."
			redirect_to user_path(current_user)
		else
			flash[:error] = "Please upload a file."
			redirect_to user_path(current_user)
		end
	end

	private
	def user
		User.friendly.find(params[:id])
	end
	def user_params
		if params[:user].present? and params[:user][:avatar].present?
		  params.require(:user).permit(:avatar)
		else
			nil
		end
	end
end
