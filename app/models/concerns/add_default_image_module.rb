module AddDefaultImageModule
  extend ActiveSupport::Concern
  included do
    # create時に初期画像設定
    after_create :add_default_image
    has_one_attached :image, dependent: :destroy
    validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: '有効な形式の画像をアップロードしてください。' },
                      size: { less_than: 5.megabytes,
                              message: 'アップロード可能な画像は5MB以下となります' }
  end
  def display_image
    image.variant(resize_to_fill: [200, 200])
  end

  private

  def add_default_image
    return if image.attached?

    image.attach(io: File.open('./app/assets/images/user_default.png'), filename: 'default_img.png')
  end
end
