class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :store_id, null: false
      t.integer :product_id, null: false
      t.integer :review_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end

    change_table :notifications, bulk: true do |t|
      t.index :user_id
      t.index :product_id
      t.index :review_id
    end
  end
end
