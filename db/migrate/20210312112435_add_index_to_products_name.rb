class AddIndexToProductsName < ActiveRecord::Migration[6.0]
  def change
    add_index :products, %i[name store_id], unique: true
  end
end
