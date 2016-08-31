include ActionView::Helpers::TextHelper # <<< for pluralize

class WorkshopsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :workshop, only: [:show, :edit, :update, :destroy]

	def index
		if params[:topic].blank?
			@workshops = Workshop.all.order("created_at DESC")
		else
			topic = Topic.find_by(name: params[:topic].downcase)
			if topic
				@workshops = Workshop.where(topic_id: topic.id).order("created_at DESC")
				flash[:notice] = "Found #{pluralize(@workshops.count, 'workshop')} with topic '#{params[:topic].titleize}'"
			else
				flash[:notice] = "No results match topic '#{params[:topic].titleize}'. Showing all workshops"
				@workshops = Workshop.all.order("created_at DESC")
			end
		end
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
