class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def likes
    @products = User.find_by(params[:id]).products.with_attached_image.includes(:store)
  end
end
