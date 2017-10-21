Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :sessions
  resources :messages
  resources :conversations
  resources :friendships
root "sessions#index"
  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create', as: nil
  delete '/logout',  to: 'sessions#destroy'

get '/auth/:provider/callback', :to => 'sessions#create'
get '/auth/failure', :to => 'sessions#failure'
end
