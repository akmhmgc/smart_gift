# frozen_string_literal: true

class Stores::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_user, only: :create
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  protected

  def ensure_normal_user
    redirect_to new_store_session_path, alert: 'ゲストストアのパスワード再設定はできません。' if params[:store][:email].downcase == 'guest_store@example.com'
  end

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
