class AddColumnPublicUidToOrders < ActiveRecord::Migration[6.0]
  def change
    change_table :orders, bulk: true do |t|
      t.column :public_uid, :string
      t.index :public_uid, unique: true
      t.integer :recipient_id
      t.index :recipient_id
      t.index [:recipient_id, :recieved]
    end
  end
end
