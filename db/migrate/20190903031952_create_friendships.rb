# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.references :friend
      t.boolean :confirmed, default: false

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
    add_index :friendships, %i[user_id friend_id]
  end
end
