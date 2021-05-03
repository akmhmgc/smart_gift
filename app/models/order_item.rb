class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  scope :belongs_to_store, lambda { |store|
    includes(:product).where(order_items: { products: { store_id: store.id } })
  }
  # validates_associated :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
