Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepages#index"
  resources :drivers, only: [:index, :create, :new, :show, :edit, :destroy]

  resources :passengers, only: [:index, :create, :new, :show, :edit, :destroy]
  post "passenger/:id/trip/", to: "trips#create", as: "passenger_create_trip"
  resources :trips, only: [:index, :show, :create]
end
