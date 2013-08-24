module Api
  module V1
  	class ShowsController < ApplicationController

    	def index
        @shows = Show.find(:all, :conditions => {:archived => false}, :order => 'title desc')

        respond_to do |format|
          format.js { render json: @shows, each_serializer: ShowListSerializer, :callback => params[:callback], root: false}
          format.json { render json: @shows, each_serializer: ShowListSerializer, root: false }
  	    end
    	end

      def onair
        if (Settings.override == true)
          @show = Show.find(Settings.override_show)
        else 
          current_day = Time.now.strftime("%A").downcase!
          @slot = Slot.find(:all, :conditions => ["quarter = ? AND start_time <= ? AND end_time >=  ? AND " + current_day + " = 't'", Settings.active_schedule, Time.now, Time.now]).first
          
          if @slot then
            @show = @slot.show
          else
            @show = Show.where("title like ?", "%HAL%").first
          end 
        end
        respond_to do |format|
          format.js { render json: @show, serializer: ShowListSerializer, :callback => params[:callback], root: false}
          format.json { render json: @show, serializer: ShowListSerializer, root: false }
        end

      end

    	def show
        @show = Show.find(params[:id])

        respond_to do |format|
          format.js { render json: @show, serializer: ShowSerializer, :callback => params[:callback], root: false}
          format.json { render json: @show, serializer: ShowSerializer, root: false }
        end
    	end
    end
  end
end