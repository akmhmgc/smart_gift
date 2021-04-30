class StaticPagesController < ApplicationController
  def home
    @products = Product.includes([:store]).with_attached_image.order("stars_average DESC").limit(5)
  end

  def home_2
    @store = Store.find(1)
    @products = @store.products
  end
end
