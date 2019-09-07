Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # All events
      resources :events, only: [:index, :show, :create]

      # All users
      resources :users, only: [:create]

      # All friendships
      namespace :friendships do
        post '/request/:friend_id', to: 'request#create'
      end

      # Specific User
      namespace :user do
        resources :events, only: [:index]
      end
      patch 'user/edit', to: 'users#update'

      # User Login
      post '/sessions', to: 'sessions#create'
    end
  end
end
