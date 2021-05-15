class DeleteForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :orders, :users
    remove_reference :orders, :user
    add_reference :orders, :user

    remove_foreign_key :order_items, :products
    remove_reference :order_items, :product
    add_reference :order_items, :products
  end
end
