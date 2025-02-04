Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "homes#index"

  resources :profiles, only: [:show]
  resources :searches, only: [:index]

  resources :posts, except: :index do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  
  resources :friend_requests, only: [:create, :destroy]
  post 'friend_requests/:id/accept', to: 'friend_requests#accept', as: 'friend_requests_accept'
  resources :users, only: [:index, :show] do
    member do
      get 'friend_requests', to: 'users#friend_requests'
    end
  end
end
