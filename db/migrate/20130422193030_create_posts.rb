class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :discussion
      t.text :content

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :discussion_id
  end
end
