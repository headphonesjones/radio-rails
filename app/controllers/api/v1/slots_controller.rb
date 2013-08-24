module Api
  module V1
  	class SlotsController < ApplicationController
	  def index
	    @slots = Slot.find(:all, :order => 'start_time', :conditions => ["quarter = ?", Settings.active_schedule])

	    respond_to do |format|
	      format.json { render json: @slots , root: false, each_serializer: ScheduleSerializer}
	      format.js { render json: @slots, each_serializer: ScheduleSerializer, root: false, :callback => params[:callback]}
	    end
	  end
    end
  end
end