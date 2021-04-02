class AddMoneyToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :money, :integer, null: false, default: 10_000
  end
end
