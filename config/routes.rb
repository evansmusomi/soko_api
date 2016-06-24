# See how all your routes lay out with "rake routes".
# For more information about routes, see the Rails guide: http://guides.rubyonrails.org/routing.html.

require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  #Defines API route mapping, default format and constraints
  namespace :api, defaults: { format: :json},
    constraints: { subdomain: 'api'}, path: '/' do
      #scopes versioning and handles version requests through headers
      scope module: :v1,
        constraints: ApiConstraints.new(version: 1, default: true) do
          resources :users, only: [:show, :create, :update, :destroy]
          resources :sessions, only: [:create, :destroy]
          resources :products, only: [:show, :index]
      end
  end
end
