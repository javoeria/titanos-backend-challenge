module Api::V1
  class UsersController < ApplicationController
    api :GET, '/users/:id/favorite_programs', 'Get a list of favorites channel programs for the user'
    param :id, :number, required: true
    def favorite_programs
      data = UserService.favorite_programs(params[:id])
      render json: { data: data }, status: :ok
    end

    api :GET, '/users/:id/favorite_apps', 'Get a list of favorites apps for the user'
    param :id, :number, required: true
    def favorite_apps
      data = UserService.favorite_apps(params[:id])
      render json: { data: data }, status: :ok
    end

    api :POST, '/users/:id/favorite_apps', 'Create a new favorite app and set its position'
    param :id, :number, required: true
    param :app_id, :number, required: true
    param :position, :number, required: true
    def create_favorite_app
      data = UserService.create_favorite_app(params[:id], params[:app_id], params[:position])
      render json: { data: data }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :bad_request
    end
  end
end
