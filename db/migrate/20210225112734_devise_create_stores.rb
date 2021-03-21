# frozen_string_literal: true

class DeviseCreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :storename

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.timestamps null: false
    end

    # add_index :stores, :email,                unique: true
    # add_index :stores, :reset_password_token, unique: true
    # add_index :stores, :confirmation_token,   unique: true
    # add_index :stores, :unlock_token,         unique: true

    change_table :stores, bulk: true do |t|
      t.index :storename,                unique: true
      t.index :email,                unique: true
      t.index :reset_password_token, unique: true
    end
  end
end
