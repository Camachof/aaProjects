Rails.application.routes.draw do
  namespace :api do
    resources :benches, defaults: { format: 'json'}
  end
  root to: "static_pages#root"
end
