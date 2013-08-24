module Api
  module V1
  	class NewsPostsController < ApplicationController

    	def index
        @news_posts = NewsPost.find(:all, :order => 'datetime_published DESC')

        respond_to do |format|
          format.js { render json: @news_posts, each_serializer: NewsListSerializer, :callback => params[:callback], root: false}
          format.json { render json: @news_posts, each_serializer: NewsListSerializer, root: false }
  	    end
    	end

    	def show
        @news_post = NewsPost.find(params[:id])

        respond_to do |format|
          format.js { render json: @news_post, serializer: NewsSerializer, :callback => params[:callback], root: false}
          format.json { render json: @news_post, serializer: NewsSerializer, root: false }
        end
    	end
    end
  end
end