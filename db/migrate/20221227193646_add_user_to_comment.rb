class AddUserToComment < ActiveRecord::Migration[6.1]
  def up
    add_reference :comments, :user, foreign_key: true
    Comment.update(user_id: User.first.id)
    change_column_null :comments, :user_id, false
  end

  def down
    emove_reference :comments, :user
  end
end
