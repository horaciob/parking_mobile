Rails.application.routes.draw do
  resources :zones
  resources :parkings
  resources :devices
  resources :payments
end
