# Below are the routes for madmin
namespace :madmin do
  resources :products
  root to: "dashboard#show"
end
