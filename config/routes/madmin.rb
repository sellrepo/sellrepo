# Below are the routes for madmin
namespace :madmin, path: :admin do
  resources :configs
  resources :licenses
  resources :announcements
  namespace :license do
    resources :users
  end
  namespace :pay do
    resources :customers
    resources :charges
    resources :subscriptions
  end
  resources :products
  resources :users do
    resource :impersonate, module: :users
  end
  namespace :active_storage do
    resources :attachments
  end
  root to: "dashboard#show"
end
