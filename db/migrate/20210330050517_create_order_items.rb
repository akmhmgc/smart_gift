class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :price, null: false, default: 0
      t.integer :quantity, null: false, default: 0
      t.timestamps
    end
  end
end
