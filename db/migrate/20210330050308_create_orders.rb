class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :sender_name
      t.text :message
      t.boolean :received, default: false, null: false
      t.timestamps
    end
  end
end
