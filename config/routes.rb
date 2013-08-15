Hitchhiker::Application.routes.draw do
  resources :trips
  resources :vehicles, only:[:index, :create]
  get 'vehicles/makes'
  get "vehicles/:makes/models", to: 'vehicles#models'
  get "vehicles/:makes/:models/years", to: 'vehicles#years'

  authenticated :user do
    root :to => 'trips#index'
  end
  match 'auth/:provider/callback', to: 'authentications#create'
  match 'auth/:provider/failure', to: redirect('/')

  match 'reservation/:trip_id', to: 'trips#reserve'

  root :to => "trips#index"
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"} ,controllers: {:registrations => "registrations"}
  resources :users
  match '*a', :to => 'errors#error_routing'
  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'

  end
end