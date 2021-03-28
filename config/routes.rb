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

  resources :users, path: '/', only: %i[show likes] do
    member do
      resource :profiles, only: %i[show update edit]
      get :favorites
    end
  end

  resources :likes, only: %i[create destroy]

  namespace :dashboard do
    resources :products
  end

  
  resources :carts, only: [:show]
  post '/add_item' => 'carts#add_item'
  post '/update_item' => 'carts#update_item'
  delete '/delete_item' => 'carts#delete_item'
end
