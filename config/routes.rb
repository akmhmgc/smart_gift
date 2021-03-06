Rails.application.routes.draw do
  devise_for :users
  devise_for :stores
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :stores, only: [:show]
  # resources :profiles, path: '/', only: %i[show edit update]
  resources :products, only: %i[show index]

  # パス名の変更
  # resources :profiles, path: '/', only: %i[show edit update] do
  #   member do
  #     get :likes
  #   end
  # end
  resources :users, path: '/', only: %i[show likes] do
    member do
      resource :profiles, only: %i[show edit update destroy]
      get :likes
    end
  end

  resources :likes, only: %i[create destroy]
end
