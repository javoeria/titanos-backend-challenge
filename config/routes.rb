Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  apipie
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get 'contents',           to: 'contents#index'
      get 'contents/:type/:id', to: 'contents#show'
      get 'contents/search',    to: 'contents#search'
    end
  end
end
