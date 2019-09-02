# frozen_string_literal: true

class CreatePostLikeBrokers < ActiveRecord::Migration[5.2]
  def change
    create_table :post_like_brokers do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :post_like_brokers, %i[post_id created_at]
    add_index :post_like_brokers, %i[user_id created_at]
    add_index :post_like_brokers, %i[post_id user_id], unique: true
  end
end
