module ImageModule
  extend ActiveSupport::Concern
  included do
    has_one_attached :image
    validates :image, presence: true, content_type: { in: %w[image/jpeg image/gif image/png],
                                                      message: '有効な形式の画像をアップロードしてください。' },
                      size: { less_than: 5.megabytes,
                              message: 'アップロード可能な画像は5MB以下となります' }
  end
  def display_image
    image.variant(resize_to_fill: [200, 200])
  end
end
