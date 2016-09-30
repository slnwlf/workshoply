class SitesController < ApplicationController
  def index
  	@featured_workshops = [Workshop.find(31), Workshop.find(27), Workshop.find(24)]
  end

  def about
  end

  def contact
  	  @message = Message.new
  end

end