class Product < ApplicationRecord
  include CommonModule
  belongs_to :store
  has_one_attached :image

  belongs_to :category

  # like
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  # image validation
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }
end
