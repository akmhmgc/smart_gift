class AddReceivedAtToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :received_at, :datetime
  end
end
