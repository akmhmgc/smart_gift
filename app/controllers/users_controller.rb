class UsersController < ApplicationController
  def show; end

  def likes
    @products = User.find_by(params[:id]).products
  end
end
