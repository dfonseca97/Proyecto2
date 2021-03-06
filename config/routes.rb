Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    resources :location, only: [:create]
  end

  get 'login', to: "users#new"
  get 'logout', to: 'logout#logout'

  get 'position/getPosition', to: 'position#getPosition', as: 'get_position'
  get 'map', to: 'map#index'
  get 'map/show', to: 'map#show', as: 'show_map'
  get 'position/save', to: 'position#save' 
  get 'position/index', to: 'position#index', as: 'index_position'
 
  get 'auth/oauth2/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'
  
  root 'position#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
