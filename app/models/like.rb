class Like < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :product_id, uniqueness: { scope: :user_id }
end
