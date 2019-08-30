class CreatePostLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :post_likes do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :post_likes, %i[post_id created_at]
    add_index :post_likes, %i[user_id created_at]
    add_index :post_likes, %i[post_id user_id], unique: true
  end
end
