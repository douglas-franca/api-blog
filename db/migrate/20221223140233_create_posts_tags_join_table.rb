class CreatePostsTagsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :posts, :tags, column_option: { null: false, foreign_key: true} do |t|
      t.index [:post_id, :tag_id]
      t.index [:tag_id, :post_id]
    end
  end
end
