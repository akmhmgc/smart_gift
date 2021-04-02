class ProfilesController < ApplicationController
  before_action :profile_setup, only: %i[show edit update add_money]
  before_action :authenticate_user!, only: %i[edit update add_money]
  before_action :correct_user, only: %i[edit update]

  def show; end

  # ログインしているユーザーが編集対象のユーザーかどうか
  def edit; end

  def add_money
    @profile.money += 10_000
    if @profile.save
      flash[:notice] = '10000円がチャージされました'
    else
      flash[:alert] = 'チャージに失敗しました'
    end
    redirect_to profiles_url(current_user)
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = 'プロフィールが変更されました'
      redirect_to profiles_url(current_user)
    else
      flash.now[:alert] = 'プロフィールの更新に失敗しました。詳細はエラーメッセージをご確認ください。'
      render 'edit'
    end
  end

  private

  def profile_params
    params.permit(:name, :image)
  end

  def profile_setup
    @profile = User.find(params[:id]).profile
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    return unless @user != current_user

    flash[:alert] = '無効なURLです'
    redirect_back(fallback_location: profiles_path(@user))
  end
end
