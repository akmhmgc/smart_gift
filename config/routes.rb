Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations' }
  devise_for :stores, controllers: { sessions: 'stores/sessions', registrations: 'stores/registrations', confirmations: 'stores/confirmations' }

  root 'static_pages#home'

  resources :stores, only: [:show] do
    get :items
  end

  resources :products , only: %i[index show] 
  resources :reviews, only: %i[create destroy edit update]
  resources :notifications, only: :index

  resources :users, path: '/', only: %i[show likes] , constraints: { id: /\d+/ } do
    member do
      resource :profiles, only: %i[show update edit]
      get 'add_money' => 'profiles#add_money'
      get :favorites
    end
  end

  resources :likes, only: %i[create destroy]

  namespace :dashboard do
    resources :products
  end

  # get '/my_cart' => 'carts#my_cart'
  # post '/add_item' => 'carts#add_item'
  # post '/update_item' => 'carts#update_item'
  # delete '/delete_item' => 'carts#delete_item'

  resource :order, only: %i[create]
  get 'giftcard/edit' => 'orders#giftcard_edit'
  post '/add_item' => 'orders#add_item'
  get 'giftcard/preview' => 'orders#giftcard_preview'
  get 'payment' => 'orders#payment'
  post '/update_item' => 'orders#update_item'
  delete '/delete_item' => 'orders#delete_item'
end
