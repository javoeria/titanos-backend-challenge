module Api::V1
  class ContentsController < ApplicationController
    api :GET, '/contents', 'Get a list of filtered contents depending on each type of content'
    param :country, String, required: true
    param :type, %w[movies tv_shows seasons episodes channels channel_programs]
    def index
      data = ContentService.all(params[:country], params[:type])
      render json: { data: data }, status: :ok
    end

    api :GET, '/contents/:type/:id', 'Get specific data for each type of content'
    param :type, %w[movies tv_shows seasons episodes channels channel_programs], required: true
    param :id, :number, required: true
    param :user_id, :number
    def show
      data = ContentService.get(params[:type], params[:id], params[:user_id])
      render json: { data: data }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Content not found' }, status: :not_found
    end

    api :GET, '/contents/search', 'Search all possible types of content based on the query'
    param :q, String, required: true
    def search
      data = ContentService.search(params[:q])
      render json: { data: data }, status: :ok
    end
  end
end
