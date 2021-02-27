class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price, default: 0
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :name
  end
end
