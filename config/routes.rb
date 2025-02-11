Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  root to: "homes#index"

  resources :profiles, only: [:show]
  resources :searches, only: [:index]

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end

  resources :friend_requests, only: [:create, :destroy]
  post "friend_requests/:id/accept", to: "friend_requests#accept", as: "friend_requests_accept"
  
  resources :users, only: [:index, :show] do
    member do
      get "friend_requests", to: "users#friend_requests"
    end
  end
end
