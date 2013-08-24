module Api
  module V1
  	class AwardsController < ApplicationController
	  def index
	    @awards = Award.find(:all, order: 'year DESC')

	    respond_to do |format|
	      format.js  { render :json => @awards, :callback => params[:callback] }
	      format.json  { render :json => @awards }
	    end
	  end
    end
  end
end