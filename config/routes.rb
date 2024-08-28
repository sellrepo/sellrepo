Rails.application.routes.draw do
  mount Mailbin::Engine, at: "/mailbin" if Rails.env.local?

  revise_auth

  authenticated -> { _1.admin? } do
    draw :madmin
  end

  resources :products, only: [ :index, :show ] do
    resource :checkout, only: [ :show ]
    namespace :checkout do
      resource :return, only: [ :show ]
    end
  end
  resources :licenses do
    resources :license_users, path: :users, controller: "licenses/users"
  end
  resource :billing, only: [ :show ]
  resource :welcome

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "products#index"
end
