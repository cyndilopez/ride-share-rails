Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepages#index"
  resources :drivers, only: [:index, :create, :new, :show, :edit, :update, :destroy]

  resources :passengers, only: [:index, :create, :new, :show, :edit, :update, :destroy]

  resources :trips, only: [:index, :show]
end
