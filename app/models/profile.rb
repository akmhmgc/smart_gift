class Profile < ApplicationRecord
  include CommonModule
  belongs_to :user
  has_one_attached :image
  validates :name, presence: true, length: { maximum: 20 }
  validates :money, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 999_999 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: '正しいファイル形式を選択して下さい。' },
                    size: { less_than: 5.megabytes,
                            message: 'ファイルは最大5MBです。' }
end
