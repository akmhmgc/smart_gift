class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def favorites
    @products = User.find(params[:id]).products.page(params[:page]).with_attached_image.includes(:store)
  end
end
