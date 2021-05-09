class Product < ApplicationRecord
  belongs_to :store
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_one_attached :image

  validates :image, presence: true, content_type: { in: %w[image/jpeg image/gif image/png],
                                                    message: '有効な形式の画像をアップロードしてください。' },
                    size: { less_than: 5.megabytes,
                            message: 'アップロード可能な画像は5MB以下となります' }
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: true, scope: :store }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than_or_equal_to: 999_999 }  # 商品にいいねされた時の通知メソッド

  def display_image
    image.variant(resize_to_fill: [200, 200])
  end

  def create_notification_like!(current_user)
    temp = Notification.where(['user_id = ? and store_id = ? and product_id = ? and action = ? ', current_user.id, store_id, id, 'like'])

    # いいねされていない場合のみ、通知レコードを作成
    return if temp.present?

    current_user.notifications.create!(
      store_id: store_id,
      product_id: id,
      action: 'like'
    )
  end

  # 商品にレビューされた時の通知メソッド
  def create_notification_review!(current_user, review_id)
    current_user.notifications.create!(
      product_id: id,
      store_id: store_id,
      review_id: review_id,
      action: 'review'
    )
  end

  def update_stars_avarage
    # stars_average = reviews.empty? ? 0.0 : reviews.average(:stars)
    stars_average = reviews.average(:stars) || 0.0
    update(stars_average: stars_average)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name price created_at category_id description ancestry]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[store category likes reviews]
  end

  def self.ransortable_attributes(_auth_object = nil)
    %w[price reviews_count stars_average]
  end
end
