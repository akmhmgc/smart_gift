class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  # validates_associated :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  def sum_of_price
    price * quantity
  end
end
