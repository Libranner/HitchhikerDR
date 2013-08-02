Hitchhiker::Application.routes.draw do
  resources :trips


  resources :vehicles, only:[:index, :create]
  get 'vehicles/makes'
  get "vehicles/:makes/models", to: 'vehicles#models'
  get "vehicles/:makes/:models/years", to: 'vehicles#years'

  authenticated :user do
    root :to => 'home#index'
  end
  match 'auth/:provider/callback', to: 'authentications#create'
  match 'auth/failure', to: redirect('/')


  root :to => "home#index"
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
             #,controllers: {omniauth_callbacks: "authentications"}
  resources :users
end