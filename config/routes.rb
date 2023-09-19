Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "currencies#index"
  resources :currencies, param: :code do
    resources :conversions
  end
end
