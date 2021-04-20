class StaticPagesController < ApplicationController
  def home
    @products = Product.includes([:store]).with_attached_image.order("stars_average DESC").limit(5)
  end

  def home_2
    # 新しくデータを作るのではなく、名前のアップデート,ポイントの変更の方がいいかも
    # ActiveRecord::Base.transaction do
    #   Category.create!(name: "テスト#{rand(0..999)}")
    #   ActiveRecord::Base.transaction(requires_new: true) do
    #     Category.create!(name: "テスト#{rand(0..999)}")
    #     raise ActiveRecord::Rollback
    #   end
    # end
  end
end
