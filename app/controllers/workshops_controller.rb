include ActionView::Helpers::TextHelper

class WorkshopsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :workshop, only: [:show, :edit, :update, :destroy]

	def index
		if params[:topic].blank? and params[:location].blank?
			@workshops = Workshop.all.order("created_at DESC")
		elsif !params[:topic].blank? and params[:location].blank?
			topic = Topic.find_by(name: params[:topic].downcase)
			if topic
				# see show_workshops(query_params, msg, param, both=false) in private
				show_workshops({topic_id: topic.id}, "with topic", params[:topic])
			else
				flash.now[:notice] = "No results match topic '#{params[:topic].titleize}'. Showing all workshops."
				@workshops = Workshop.all.order("created_at DESC")
			end
		elsif params[:topic].blank? and !params[:location].blank?
			show_workshops({location: params[:location].downcase}, "in", params[:location])
		elsif !params[:topic].blank? and !params[:location].blank?
			topic = Topic.find_by(name: params[:topic].downcase)
			if topic 
				show_workshops({location: params[:location].downcase, topic_id: topic.id}, nil, nil, true)
			end
		end
	end

	def show
		# see workshop method in private
		@review = Review.new
	end

	def new
		@workshop = Workshop.new
	end

	def create
		@workshop = current_user.workshops.create(workshop_params)
		if @workshop.save
			flash.now[:notice] = "Successfully create a workshop."
			redirect_to workshop_path(@workshop)
		else
			flash.now[:error] = @workshop.errors.full_messages.join(", ")
			redirect_to new_workshop_path
		end

	end

	def edit
		unless current_user == @workshop.user
			flash.now[:error] = "You can only edit your own posted workshop."
			redirect_to workshop_path(@workshop)
		end
	end

	def update
		if current_user == @workshop.user
			if @workshop.update_attributes(workshop_params)
				flash.now[:notice] = "Successfully edit the workshop."
				redirect_to workshop_path(@workshop)
			else
				flash.now[:notice] = @workshop.errors.full_messages.join(", ")
				redirect_to edit_workshop_path(@workshop)
				
			end
		else
			flash.now[:error] = "You can only edit your own posted workshop."
			redirect_to workshop_path(@workshop)
		end
	end

	def destroy
		if current_user == @workshop.user
			@workshop.destroy
			flash.now[:notice] = "Successfully delete the workshop."
			redirect_to workshops_path
		else
			flash.now[:error] = "You can only delete your own posted workshop."
			redirect_to workshop_path(@workshop)
		end
	end

	private

	def workshop
		@workshop = Workshop.friendly.find(params[:id])
	end

	def workshop_params
		params.require(:workshop).permit(:title, :description, :location, :user_id, :slug, :image, :topic_id)
	end

	def show_workshops(query_params, msg, param, both=false)
		if both
			workshops = Workshop.filter_city_and_topic(query_params[:location], query_params[:topic_id])
		else
			if query_params[:location]
				workshops = Workshop.filter_city(query_params[:location])
			else
				workshops = Workshop.filter_topic(query_params[:topic_id])
			end
		end
		if workshops.count > 0
			if both
				flash.now[:notice] = "Found #{pluralize(workshops.count, 'workshop')} with topic '#{params[:topic].titleize}' in '#{params[:location].titleize}'"
			else
				flash.now[:notice] = "Found #{pluralize(workshops.count, 'workshop')} #{msg} '#{param.titleize}'"
			end
			@workshops = workshops
		else
			if both
				flash.now[:error] = "No workshops with topic '#{params[:topic].titleize}' in '#{params[:location].titleize}'. Showing all workshops"
			else
				flash.now[:error] = "No workshops #{msg} '#{param.titleize}'. Showing all workshops."
			end
			@workshops = Workshop.all.order("created_at DESC")
		end
	end

end
