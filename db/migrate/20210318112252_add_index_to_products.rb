class AddIndexToProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products, bulk: true do |t|
      t.column :description, :text
      t.column :publish, :boolean, default: true, null: false
      t.column :stock, :integer, default: 0
      t.index :publish
    end
  end
end
