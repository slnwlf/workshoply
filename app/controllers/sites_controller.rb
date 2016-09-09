class SitesController < ApplicationController
  def index
  	@featured_workshops = [Workshop.find(1), Workshop.find(2), Workshop.find(3)]
  end

  def about
  end

  def contact
  	  @message = Message.new
  end

end
