Rails.application.routes.draw do
  devise_for :users
  devise_for :stores
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stores, only: [:show]
  resources :users, only: [:show]
  resources :products, only: %i[show index]
end
