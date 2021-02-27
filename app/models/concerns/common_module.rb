module CommonModule
  extend ActiveSupport::Concern

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_fill: [200, 200])
  end
end
