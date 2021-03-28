class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def sum_of_price
    product.price * quantity
  end
end
