Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # All events
      resources :events, only: [:index, :show, :create]

      # Update an event
      patch 'events/:id/edit', to: 'events#update'

      # All users
      resources :users, only: [:create]

      # User Events - invite, accept, decline
      resources :user_events, only: [:create, :update, :destroy]

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
