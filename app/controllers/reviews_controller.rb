class ReviewsController < ApplicationController
	before_action :authenticate_user!, :workshop

	def new
		@review =  Review.new
	end
	
	def create
		byebug
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

end
