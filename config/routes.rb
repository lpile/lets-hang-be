Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # All events
      resources :events, only: [:index, :show, :create]

      # Update an event
      patch 'events/:id/edit', to: 'events#update'

      # All users
      resources :users, only: [:create]

      # All friendships
      namespace :friendships do
        post '/request/:friend_id', to: 'request#create'
        delete '/decline/:request_id', to: 'request#destroy'
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
