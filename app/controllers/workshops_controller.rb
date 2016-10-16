include ActionView::Helpers::TextHelper

class WorkshopsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :workshop, only: [:show, :edit, :update, :destroy]

	def index
		if params[:topic].blank? and params[:location].blank?
			@workshops = Workshop.paginate(page: params[:page], per_page: 10).order("created_at DESC")
		elsif !params[:topic].blank? and params[:location].blank?
			topic = Topic.find_by(name: params[:topic].downcase)
			if topic
				# see show_workshops(query_params, msg, param, both=false) in private
				show_workshops({topic_id: topic.id}, "with topic", params[:topic])
			else
				flash.now[:notice] = "No results match topic '#{params[:topic].titleize}'. Showing all talks."
				@workshops = Workshop.paginate(page: params[:page], per_page: 10).order("created_at DESC")
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
		if current_user
			@reviews = @workshop.reviews.where('user_id != ?', current_user.id)
			@current_user_review = @workshop.reviews.where(user_id: current_user.id).first
		else
			@reviews = @workshop.reviews
		end
	end

	def new
		@workshop = Workshop.new
	end

	def create
		@workshop = current_user.workshops.create(workshop_params)
		if @workshop.save
			flash[:notice] = "Your talk was successfully created."
			redirect_to workshop_path(@workshop)
		else
			flash[:error] = @workshop.errors.full_messages.join(", ")
			render :new
		end

	end

	def edit
		unless current_user == @workshop.user
			flash[:error] = "You can only edit your own posted talk."
			redirect_to workshop_path(@workshop)
		end
	end

	def update
		if current_user == @workshop.user
			if @workshop.update_attributes(workshop_params)
				flash[:notice] = "Your talk was successfully edited."
				redirect_to workshop_path(@workshop)
			else
				flash[:notice] = @workshop.errors.full_messages.join(", ")
				render :edit
				
			end
		else
			flash[:error] = "You can only edit your own talk."
			redirect_to workshop_path(@workshop)
		end
	end

	def destroy
		if current_user == @workshop.user
			@workshop.destroy
			flash[:notice] = "Your talk has been deleted."
			redirect_to workshops_path
		else
			flash[:error] = "You can only delete your own talk."
			redirect_to workshop_path(@workshop)
		end
	end

	private

	def workshop
		@workshop = Workshop.friendly.find(params[:id])
	end

	def workshop_params
		params.require(:workshop).permit(:title, :description, :user_id, :slug, :image, :topic, :format, :price, :duration, :topic_id, :format_id, :price_id, :duration_id, :expected_outcomes)
	end

	def show_workshops(query_params, msg, param, both=false)
		if both
			workshops = Workshop.filter_city_and_topic(query_params[:location], query_params[:topic_id]).paginate(page: params[:page], per_page: 10).order("created_at DESC")
		else
			if query_params[:location]
				workshops = Workshop.filter_city(query_params[:location]).paginate(page: params[:page], per_page: 10).order("created_at DESC")
			else
				workshops = Workshop.filter_topic(query_params[:topic_id]).paginate(page: params[:page], per_page: 10).order("created_at DESC")
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
				flash.now[:error] = "No talks with topic '#{params[:topic].titleize}' in '#{params[:location].titleize}'. Showing all talks."
			else
				flash.now[:error] = "No talks #{msg} '#{param.titleize}'. Showing all talks."
			end
			@workshops = Workshop.paginate(page: params[:page], per_page: 10).order("created_at DESC")
		end
	end

end
