class UsersController < ApplicationController
  before_action :authenticate_user!
  def show; end

  def likes
    @products = User.find_by(params[:id]).products
  end
end
