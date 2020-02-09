Rails.application.routes.draw do
  root "products#index"

  resources :orders, only: %i(show)

  namespace :momo do
    resources :payments, only: %i(create show) do
      member do
        post :update
      end
    end
  end
end
