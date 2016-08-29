class WorkshopsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :workshop, only: [:show, :edit, :update, :destroy]

	def index
		@workshops = Workshop.all
	end

	def show
		# see workshop method in private
	end

	def new
		@workshop = Workshop.new
	end

	def create
		@workshop = current_user.workshops.create(workshop_params)
		if @workshop.save
			flash[:notice] = "Successfully create a workshop."
			redirect_to workshop_path(@workshop)
		else
			flash[:error] = @workshop.errors.full_messages.join(", ")
			redirect_to new_workshop_path
		end

	end

	def edit
		unless current_user == @workshop.user
			flash[:error] = "You can only edit your own posted workshop."
			redirect_to workshop_path(@workshop)
		end
	end

	def update
		if current_user == @workshop.user
			if @workshop.update_attributes(workshop_params)
				flash[:notice] = "Successfully edit the workshop."
				redirect_to workshop_path(@workshop)
			else
				flash[:notice] = @workshop.errors.full_messages.join(", ")
				redirect_to edit_workshop_path(@workshop)
				
			end
		else
			flash[:error] = "You can only edit your own posted workshop."
			redirect_to workshop_path(@workshop)
		end
	end

	def destroy
		if current_user == @workshop.user
			@workshop.destroy
			flash[:notice] = "Successfully edit the workshop."
			redirect_to workshops_path
		else
			flash[:error] = "You can only delete your own posted workshop."
			redirect_to workshop_path(@workshop)
		end
	end

	private

	def workshop
		@workshop = Workshop.friendly.find(params[:id])
	end

	def workshop_params
		params.require(:workshop).permit(:title, :description, :location, :user_id, :slug, :image)
	end
end
