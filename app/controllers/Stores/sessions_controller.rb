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
    sign_in store
    flash[:notice] = "ゲストストアとしてログインしました"
    redirect_to dashboard_products_path
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(_resource)
    dashboard_products_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
