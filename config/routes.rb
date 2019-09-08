Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # All events
      resources :events, only: [:show, :create, :update]

      # All users
      resources :users, only: [:create, :update]

      # All friendships
      resources :friendships, only: [:create, :update, :destroy]

      # User Events - invite, accept, decline
      resources :user_events, only: [:create, :update, :destroy]

      # Specific User
      namespace :user do
        resources :events, only: [:index]
        resources :friends, only: [:index]
      end

      # User Login
      post '/sessions', to: 'sessions#create'
    end
  end
end
