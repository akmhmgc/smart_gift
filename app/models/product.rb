class Product < ApplicationRecord
  include CommonModule
  belongs_to :store
  has_one_attached :image

  belongs_to :category

  # like
  has_many :likes, dependent: :destroy

  # review
  has_many :reviews, dependent: :destroy

  # notification
  has_many :notifications, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  # image validation
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: 5.megabytes,
                            message: 'should be less than 5MB' }

  # 商品にいいねされた時の通知メソッド
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
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
end
