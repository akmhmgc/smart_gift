Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  get 'stores/show'
  devise_for :stores
  get 'static_pages/home'
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stores, only: [:show]
  resources :products, only: %i[show index]
end
