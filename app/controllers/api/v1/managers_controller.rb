module Api
  module V1
  	class ManagersController < ApplicationController

    	def index
        @managers = Manager.all

        respond_to do |format|
          format.js { render json: @managers, each_serializer: ManagerSerializer, :callback => params[:callback], root: false}
          format.json { render json: @managers, each_serializer: ManagerSerializer, root: false }
  	    end
    	end

    end
  end
end