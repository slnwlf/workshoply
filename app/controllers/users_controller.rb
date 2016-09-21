class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :find_user

	def show
		@workshops = @user.workshops.paginate(page: params[:page], per_page: 5).order("created_at DESC")
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			if also_change_email?
				flash[:notice] = "Successfully update profile. You will receive an email to confirm your new email."
			else
				flash[:notice] = "Successfully update profile."
			end
			redirect_to user_path(current_user)
		else
			flash[:error] = @user.errors.full_messages.join(", ")
			render :edit
		end
	end

	private

	def find_user
		@user = User.friendly.find(params[:id])
	end

	def user_params
	  params.require(:user).permit(:full_name, :email, :avatar, :bio, :location, :organization)
	end

	def also_change_email?
		if params[:user][:email] == current_user.email
			return false
		else
			return true
		end
	end
end
