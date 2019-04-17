Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepages#index"
  resources :drivers, only: [:index, :create, :new, :show, :edit, :destroy]

  resources :passengers, only: [:index, :create, :new, :show, :edit, :destroy]
  post "/trip/:id", to: "trips#create", as: "create_trip"
  resources :trips, only: [:index, :show, :update]
end
