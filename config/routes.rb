Rails.application.routes.draw do
  default_url_options protocol: :https
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'event/get_location'
  get 'event/map'
  get 'event/store'
  get 'event/get_date'
  root :to =>'home#index'
  namespace :api, default: {format: 'json'} do

    resources :location, only: [:create]
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
