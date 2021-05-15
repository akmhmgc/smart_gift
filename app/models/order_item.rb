class OrderItem < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :order
  belongs_to :store, optional: true
  has_one_attached :product_image

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
