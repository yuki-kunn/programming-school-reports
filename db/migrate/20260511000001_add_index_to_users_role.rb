class AddIndexToUsersRole < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :role unless index_exists?(:users, :role)
  end
end
