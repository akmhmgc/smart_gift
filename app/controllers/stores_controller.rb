class StoresController < ApplicationController
  def show
    @store = Store.find(params[:id])
    @products = @store.products.page(params[:page]).per(10).with_attached_image
  end
end
