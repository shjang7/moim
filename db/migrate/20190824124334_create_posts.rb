class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.references :author
      t.timestamps
    end
    add_index :posts, %i[author_id created_at]
  end
end
