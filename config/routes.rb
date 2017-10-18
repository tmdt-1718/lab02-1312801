Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :users
resources :sessions
resources :messages
resources :conversations
root "sessions#index"
get    '/login',   to: 'sessions#new'
post   '/login',   to: 'sessions#create'
end
