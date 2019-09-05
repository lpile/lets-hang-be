Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # All events
      resources :events, only: [:index, :create]

      # All users
      resources :users, only: [:create]

      # Specific User
      namespace :user do
        resources :events, only: [:index]
      end

      # User Login
      post '/sessions', to: 'sessions#create'

      # Edit User
      patch 'user/edit', to: 'users#update'
    end
  end
end
