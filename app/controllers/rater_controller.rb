class RaterController < ApplicationController
	before_action :authenticate_user!

  def create
  	if workshop and workshop.user != current_user
	    obj = params[:klass].classify.constantize.find(params[:id])
	    obj.rate params[:score].to_f, current_user, params[:dimension]
	    render :json => true
	  else
	  	render :json => false
	  end
  end

  private
  def workshop
  	if params[:klass] == "Workshop"
  		Workshop.find(params[:id])
  	else
  		nil
  	end
  end
end
