class AddProductNamesToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :product_name, :string
  end
end
