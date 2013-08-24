module Api
  module V1
  	class PeopleController < ApplicationController

    	def index
        @people = Person.find(:all, :conditions => {:archived => false}, :order => 'first_name')

        respond_to do |format|
          format.js { render json: @people, each_serializer: PersonListSerializer, :callback => params[:callback], root: false}
          format.json { render json: @people, each_serializer: PersonListSerializer, root: false }
  	    end
    	end

    	def show
        @person = Person.find(params[:id])
        respond_to do |format|
          format.js { render json: @person, serializer: PersonSerializer, :callback => params[:callback], root: false}
          format.json { render json: @person, serializer: PersonSerializer, root: false }
        end
    	end
    end
  end
end