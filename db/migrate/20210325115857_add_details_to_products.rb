class AddDetailsToProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products, bulk: true do |t|
      t.column :reviews_count, :integer, null: false, default: 0
      t.column :stars_average, :float, null: false, default: 0.0
    end
  end
end
