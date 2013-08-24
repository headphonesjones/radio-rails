module Api
  module V1
  	class EventsController < ApplicationController

      def index
        @events = Event.all

        respond_to do |format|
          format.js { render json: @events, each_serializer: EventSerializer, :callback => params[:callback], root: false}
          format.json { render json: @events, each_serializer: EventSerializer, root: false }
  	    end
      end

    	
    end
  end
end