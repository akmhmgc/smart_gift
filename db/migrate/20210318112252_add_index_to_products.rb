class AddIndexToProducts < ActiveRecord::Migration[6.0]
  def change
    change_table :products, bulk: true do |t|
      t.column :description, :text
    end
  end
end
