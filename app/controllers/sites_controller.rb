class SitesController < ApplicationController
  def index
    @share_title = "BigTalker - A marketplace for onsite workshops, seminars, and guest speakers"
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