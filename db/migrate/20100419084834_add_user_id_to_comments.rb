class AddUserIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_id, :integer
    add_index :comments, :user_id, :integer
  end

  def self.down
    remove_column :comments, :user_id
    remove_index :comment, :user_id
  end
end
