class AddStorenameToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :storename, :string
  end
end
