class StaticPagesController < ApplicationController
  def home
    @products = Product.includes([:store]).with_attached_image.order("stars_average DESC").limit(5)
  end

end
