Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  mount ActionCable.server => '/cable'

  post '/login', to: 'sessions#create'
  post '/signup', to: 'users#create'
  get '/me', to: 'users#me'
  get '/users/search', to: 'users#search'

  resources :campaigns

  resources :campaign_users, only: [:index, :create]
  delete '/campaign_users', to: 'campaign_users#destroy'


end
