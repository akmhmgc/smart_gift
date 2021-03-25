class AddStarsToReviews < ActiveRecord::Migration[6.0]
  def change
    add_column :reviews, :stars, :integer, null: false, default: 0
  end
end
