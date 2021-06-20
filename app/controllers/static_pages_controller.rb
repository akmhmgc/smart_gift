class StaticPagesController < ApplicationController
  def home
    @products_top5 = Product.eager_load([:store], [{ image_attachment: :blob }]).order("stars_average DESC").limit(5)
  end
end
