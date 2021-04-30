class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, dependent: :destroy, index: { unique: true }
      t.string :name

      t.timestamps
    end
  end
end
