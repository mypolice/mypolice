class AddWhoIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :who_id, :integer
    add_index :posts, :who_id
  end

  def self.down
    remove_column :posts, :who_id, :integer
    remove_index :posts, :who_id
  end
end
