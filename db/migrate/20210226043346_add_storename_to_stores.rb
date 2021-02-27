class AddStorenameToStores < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :storename, :string, default: 'Store'
  end
end
