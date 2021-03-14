Rails.application.routes.draw do
  get 'reviews/create'
  get 'reviews/destroy'
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  devise_for :stores
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stores, only: [:show]
  # resources :profiles, path: '/', only: %i[show edit update]
  # resources :products, only: %i[show index] do
  #   member do
  #     resource :reviews, only: %i[create destroy]
  #   end
  # end

  resources :products, only: %i[show index]
  resources :reviews, only: %i[create destroy]

  resources :notifications, only: :index

  # パス名の変更
  # resources :profiles, path: '/', only: %i[show edit update] do
  #   member do
  #     get :likes
  #   end
  # end
  resources :users, path: '/', only: %i[show likes] do
    member do
      resource :profiles, only: %i[show update edit]
      get :likes
    end
  end

  resources :likes, only: %i[create destroy]
end
