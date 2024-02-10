Rails.application.routes.draw do
  resources :tickets
  resources :reviews
  resources :events
  resources :rooms
  resources :users

  root 'home#index'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  resources :sessions, only: [:new, :create, :destroy]
  get "up" => "rails/health#show", as: :rails_health_check
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to:"sessions#new", as:'login'
  get 'logout', to:"sessions#destroy",as:'logout'
  get '/users/:id', to:"users#show",as:'profile'
  # Defines the root path route ("/")
  # root "posts#index"
end
