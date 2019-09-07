Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # All events
      resources :events, only: [:index, :show, :create]

      # Update an event
      patch 'events/:id/edit', to: 'events#update'

      # All users
      resources :users, only: [:create]

      # Specific User
      namespace :user do
        resources :events, only: [:index]
      end
      patch 'user/edit', to: 'users#update'

      # Adding/Updating UserEvents upon inviting and accepting
      namespace :event do
        post '/invite/:friend_id', to: 'invite#create'
        patch '/accept/:user_id', to 'invite#update'
        delete '/decline/:user_id', to 'invite#destroy'
      end

      # User Login
      post '/sessions', to: 'sessions#create'
    end
  end
end
