class SitesController < ApplicationController
  def index
  	if Rails.env.production?
	  	@featured_workshops = [Workshop.find(31), Workshop.find(27), Workshop.find(24)]
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