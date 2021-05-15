class AddForeingkey < ActiveRecord::Migration[6.0]
  def change
    remove_reference :order_items, :products
    add_reference :order_items, :product
  end
end
