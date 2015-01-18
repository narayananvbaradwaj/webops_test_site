class AddIndexToUsersRoll < ActiveRecord::Migration
  def change
    add_index :users, :roll, unique: true
  end
end
