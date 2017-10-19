Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root "sessions#index"
  get    '/login',   to: 'sessions#new', as: :login
  post   '/login',   to: 'sessions#create', as: nil
  delete '/logout',  to: 'sessions#destroy'
resources :users
resources :sessions
resources :messages
resources :conversations
resources :friendships
end
