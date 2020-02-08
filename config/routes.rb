Rails.application.routes.draw do
  root "products#index"

  namespace :momo do
    resources :payments, only: %i(create show) do
      member do
        post :update
      end
    end
  end
end
