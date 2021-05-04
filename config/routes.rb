Rails.application.routes.draw do
  devise_for :users, 
             controllers: { sessions: 'users/sessions', registrations: 'users/registrations', confirmations: 'users/confirmations', passwords: 'users/passwords', 
                            omniauth_callbacks: "users/omniauth_callbacks" }
  devise_for :stores, 
             controllers: { sessions: 'stores/sessions', registrations: 'stores/registrations', confirmations: 'stores/confirmations', 
                            passwords: 'stores/passwords' }
  
  devise_scope :user do
    get 'user/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_scope :store do
    get 'store/guest_sign_in', to: 'stores/sessions#new_guest'
  end

  root 'static_pages#home'
  get 'home_2', to: 'static_pages#home_2'

  resources :stores, only: [:show]

  resources :products , only: %i[index show] 
  resources :reviews, only: %i[create destroy edit update]
  resources :notifications, only: :index

  resources :users, path: '/', only: %i[show likes] , constraints: { id: /\d+/ } do
    member do
      resource :profiles, only: %i[show update edit]
      post 'add_money' => 'profiles#add_money'
      get :favorites
    end
  end

  resources :likes, only: %i[create destroy]

  # 店舗用ページ
  namespace :dashboard do
    resources :products
    controller :orders do
      resources :orders, only: %i[show]
    end
  end

  # controller :orders do
  #   scope module: :dashboard do
  #     get "test", action: :test
  #   end
  # end
  

  resource :order, only: %i[create]
  get 'giftcard/edit' => 'orders#giftcard_edit'
  get 'giftcards/:id' => 'orders#giftcard_show', as: 'giftcard'
  post 'giftcards/:id' => 'orders#giftcard_receive', as: 'giftcard_receive'
  post '/add_item' => 'orders#add_item'
  get 'giftcard/preview' => 'orders#giftcard_preview'
  get 'payment' => 'orders#payment'
  post '/update_item' => 'orders#update_item'
  delete '/delete_item' => 'orders#delete_item'

  namespace :mypage do
    get 'order_histories' => 'orders#orders_index'
    get 'order_histories/:id' => 'orders#orders_show' , as: 'order_history'
    get 'gifts' => 'orders#gifts_index'
  end

  # 店舗用root pathの作成
  get 'dashboard/report', to: 'dashboard/orders#report', as: "store_root"
end
