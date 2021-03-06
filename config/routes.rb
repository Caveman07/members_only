Rails.application.routes.draw do
  root 'users#index'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  #sessions
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
