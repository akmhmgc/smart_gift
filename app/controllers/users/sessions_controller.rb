# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include Accessible
  skip_before_action :check_user, only: :destroy

  def new
    session.delete('devise.omniauth_data')
    super
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    user = User.guest
    profile = user.profile || user.build_profile
    # profile情報の初期化
    profile.name = user.username
    profile.image.attach(io: File.open('./app/assets/images/user_default.png'), filename: 'user.png')
    profile.save
    
    sign_in user
    flash[:notice] = "ゲストユーザーとしてログインしました"
    redirect_to stored_location_for(:user) || root_url
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end
end
