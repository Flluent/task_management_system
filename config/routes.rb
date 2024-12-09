Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "tasks#index"

  get "/tasks/new", to: "tasks#new"
  get "/tasks/:id", to: "tasks#show"
  get "/tasks/:id/edit", to: "tasks#edit"
  patch "/tasks/:id", to: "tasks#update"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  get "/profile", to: "users#show"

  resources :tasks do
    member do
      get "delete"
    end
  end

  resources :users, only: [ :index, :show, :new, :create ]

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
