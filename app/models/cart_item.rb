class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def sum_of_price
    product.price * quantity
  end
end
