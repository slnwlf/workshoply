class SitesController < ApplicationController
  def index
  	@workshops = Workshop.all
  	@workshop1 = Workshop.find(1)
  	@workshop2 = Workshop.find(3)
  	@workshop3 = Workshop.find(5)
  end

  def about
  end
end
