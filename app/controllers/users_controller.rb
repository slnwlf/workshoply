class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :find_user

	def show
		if @user.location and @user.organization
      @workshops = @user.workshops.paginate(page: params[:page], per_page: 5).order("created_at DESC")
    else
    	# redirect oauth user which haven't filled out organizaion and location
      if current_user and current_user.admin? and @user.uid
      	flash[:notice] = "This OAuth user haven't update organztion and location yet."
      	redirect_to edit_user_path(@user)
      elsif current_user and !current_user.admin? and @user.uid
      	flash[:notice] = "Please update missing information before you can continue."
      	redirect_to edit_user_path(@user)
      elsif !current_user
      	# handle when user try to look at OAuth user profile which does not have location and organization yet
      	flash[:notice] = "#{@user.full_name}\'s profile not yet completed."
      	redirect_to workshops_path
      end
    end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			if also_change_email?
				flash[:notice] = "Your profile was successfully updated. You will receive an email to confirm your new email."
			else
				flash[:notice] = "Your profile was successfully updated."
			end

			# session is for oauth user
			redirect_to session[:last_page] || user_path(@user)
			session[:last_page] = nil
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
	  params.require(:user).permit(:full_name, :email, :avatar, :bio, :location, :organization, :link_to_bio)
	end

	def also_change_email?
		if params[:user][:email] == current_user.email || (current_user.admin && params[:user][:email] == @user.email)
			return false
		else
			return true
		end
	end
end
