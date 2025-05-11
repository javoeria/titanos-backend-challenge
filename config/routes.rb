Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  apipie
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get 'contents',           to: 'contents#index'
      get 'contents/:type/:id', to: 'contents#show'
      get 'contents/search',    to: 'contents#search'

      get 'users/:id/favorite_programs', to: 'users#favorite_programs'
      get 'users/:id/favorite_apps',     to: 'users#favorite_apps'
      post 'users/:id/favorite_apps',    to: 'users#create_favorite_app'
    end
  end
end
