class ReviewsController < ApplicationController
	include ReviewsHelper
	before_action :authenticate_user!, :workshop
	before_action :review, only: [:edit, :update, :destroy]

	def new
		if current_user_reviewed?
			flash[:error] = "You can only write one review per talk. You can edit your old review."
			redirect_to workshop_path(@workshop)
		else
			@review =  Review.new
		end
		unless @workshop.user != current_user
			flash[:error] = "You can't review your own talk."
			redirect_to workshop_path(@workshop)
		end
	end
	
	def create
		if current_user != @workshop.user
			if params[:score].empty?
				flash[:error] = "Please rate the talk."
				redirect_to new_workshop_review_path(@workshop)
			else
				@review = @workshop.reviews.create(review_params)
				if @review.save
					current_user.reviews << @review
					flash[:notice] = "Successfully post your review."
					redirect_to workshop_path(@workshop)
				else
					flash[:error] = @review.errors.full_messages.join(", ")
					redirect_to new_workshop_review_path(@workshop)
				end
			end
		else
			flash[:error] = "You can't review your own talk."
			redirect_to workshop_path(@workshop)
		end
	end

	def edit
		unless current_user_reviewed? and current_user == @review.user
			flash[:error] = "You can only edit your own review."
			redirect_to workshop_path(@workshop)
		end
	end

	def update
		if current_user_reviewed? and current_user == @review.user
			if @review.update_attributes(review_params)
				flash[:notice] = "Successfully edit your review."
				redirect_to workshop_path(@workshop)
			else
				flash[:error] = @review.errors.full_messages.join(", ")
				redirect_to edit_workshop_review_path(@workshop, @review)
			end
		else
			flash[:error] = "You can only edit your own review."
			redirect_to workshop_path(@workshop)
		end
	end

	def destroy
		if current_user_reviewed? and current_user == @review.user
			# clear user rating, update average rating score
			clear_rating(current_user, "rating", @workshop)  #<<< see ReviewsHelper
			@review.destroy
			flash[:notice] = "Successfully delete your review."
			redirect_to workshop_path(@workshop)
		else
			flash[:error] = "You can only delete your own review."
			redirect_to workshop_path(@workshop)
		end
	end

	private

	def review_params
		params.require(:review).permit(:text)
	end

	def workshop
		@workshop = Workshop.friendly.find(params[:workshop_id])
	end

	def current_user_reviewed?
		if Review.where({user_id: current_user.id, workshop_id: @workshop.id}).count > 0
			true
		else
			false
		end
	end

	def review
		@review = Review.where({user_id: current_user.id, workshop_id: @workshop.id}).first
	end

end
