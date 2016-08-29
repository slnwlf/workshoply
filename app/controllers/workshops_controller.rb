class WorkshopsController < ApplicationController

	def index
		@workshops = Workshop.all
	end

	def show
		# @workshops = Workshop.all   # <<<<< dont need this because this is for all workshops in index
		@workshop = workshop   # << see workshop method in private
	end

	private

	def workshop
		Workshop.friendly.find(params[:id])
	end
end
