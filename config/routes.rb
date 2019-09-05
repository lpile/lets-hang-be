Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :events, only: [:index]
      resources :users, only: [:create]
      namespace :user do
        resources :events, only: [:index]
      end
    end
  end
end
