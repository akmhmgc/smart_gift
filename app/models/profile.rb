class Profile < ApplicationRecord
  include CommonModule
  belongs_to :user
  has_one_attached :image
  validates :name, length: { maximum: 20 }
  # image validation
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: '正しいファイル形式を選択して下さい。' },
                    size: { less_than: 5.megabytes,
                            message: 'ファイルは最大5MBです。' }
end
