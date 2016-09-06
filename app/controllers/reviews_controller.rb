class ReviewsController < ApplicationController
	before_action :authenticate_user!, :workshop

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
			@review = @workshop.reviews.create(review_params)
			if @review.save
				current_user.reviews << @review
				flash[:notice] = "Successfully post your review."
				redirect_to workshop_path(@workshop)
			else
				flash.now[:error] = @review.errors.full_messages.join(", ")
				redirect_to workshop_path(@workshop)
			end
		else
			flash[:error] = "You can't review your own talk."
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

end
