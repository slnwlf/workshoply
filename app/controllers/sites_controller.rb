class SitesController < ApplicationController
  def index
    @share_title = "BigTalker - A marketplace for onsite workshops, seminars, and guest speakers"
  	if Rails.env.production?
      @featured_workshops = [Workshop.find(106), Workshop.find(107), Workshop.find(91)]
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