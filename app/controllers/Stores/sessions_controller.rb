# frozen_string_literal: true

class Stores::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def new_guest
    store = Store.guest
    store.image.attach(io: File.open('./app/assets/images/user_default.png'), filename: 'store.png')

    # 商品の初期化
    notifications = store.notifications
    notifications.update_all(checked: false)
    item1 = store.products.order(:created_at).first
    item2 = store.products.order(:created_at).second
    item1.image.attach(io: File.open('./app/assets/images/chocolate_1-min.jpeg'), filename: 'store_2_product.jpeg')
    item1.update(name: "おいしいチョコバー",
                 price: 450,
                 category_id: Category.find_by(name: "チョコレート").id,
                 description: 'おいしいチョコバーです。')

    sleep 0.5
    item2.image.attach(io: File.open('./app/assets/images/chocolate_2-min.jpeg'), filename: 'store_2_product.jpeg')
    item2.update(name: "いちごのチョコレート",
                 price: 560,
                 category_id: Category.find_by(name: "チョコレート").id,
                 description: 'いちごのチョコレートです。')

    sign_in store
    flash[:notice] = "ゲストストアとしてログインしました"
    redirect_to store_root_path
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # def after_sign_in_path_for(_resource)
  #   dashboard_products_path
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
