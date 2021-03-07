class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :product_id, presence: true

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 140 }
end
