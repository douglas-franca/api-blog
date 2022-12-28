class AddPasswordToUsers < ActiveRecord::Migration[6.1]
  # def change
  #   add_column :users, :password_digest, :string, null: false
  # end

  def up 
    add_column :users, :password_digest, :string, null: false
    User.update(password: 'Sample123')
  end

  def down
    remove_column :users, :password_digest
  end
end
