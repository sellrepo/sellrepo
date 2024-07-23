# Below are the routes for madmin
namespace :madmin do
  resources :configs
  resources :products
  resources :licenses
  resources :users
  namespace :pay do
    resources :customers
    resources :charges
  end
  root to: "dashboard#show"
end
