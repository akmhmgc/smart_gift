class AddAncestryToCategory < ActiveRecord::Migration[6.0]
  def change
    change_table :categories, bulk: true do |t|
      t.column :ancestry, :string
      t.index :ancestry
    end
  end
end
