class ProfilesController < ApplicationController
  before_action :profile_setup, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[edit update]
  before_action :correct_user, only: %i[edit update]

  def show; end

  # ログインしているユーザーが編集対象のユーザーかどうか
  def edit; end

  def update
    if @profile.update(profile_params)
      flash[:notice] = 'プロフィールが変更されました'
      redirect_to profiles_url(current_user)
    else
      render 'edit'
    end
  end

  def profile_params
    params.permit(:name, :image)
  end

  private

  def profile_setup
    @profile = User.find_by(params[:id]).profile
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
