class AddColumnToStore < ActiveRecord::Migration[6.0]
  def change
    add_column :stores, :description, :text
  end
end
