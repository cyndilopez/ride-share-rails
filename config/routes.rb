Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :drivers, only: [:index]

  resources :passengers, only: [:index]

  resources :trips, only: [:index]
end
