Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations' }
  devise_for :stores, controllers: { sessions: 'stores/sessions', registrations: 'stores/registrations', confirmations: 'stores/confirmations' }

  root 'static_pages#home'

  resources :stores, only: [:show] do
    get :items
  end

  resources :products
  resources :reviews, only: %i[create destroy]
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
end
