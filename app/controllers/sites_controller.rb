class SitesController < ApplicationController
  def index
  	@workshops = Workshop.all
  	@workshop = Workshop.find(params[:id])
  end

  def about
  end
end
