class SitesController < ApplicationController
  def index
  	if Rails.env.production?
	  	@featured_workshops = [Workshop.find(57), Workshop.find(54), Workshop.find(51)]
	  else
	  	@featured_workshops = Workshop.order("RANDOM()").limit(3)
	  end
  end

  def about
  end

  def contact
  	  @message = Message.new
  end

end