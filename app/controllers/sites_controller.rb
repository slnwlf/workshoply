class SitesController < ApplicationController
  def index
  	@workshops = Workshop.all
  end

  def about
  end
end
