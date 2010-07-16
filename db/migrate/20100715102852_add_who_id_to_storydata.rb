class AddWhoIdToStorydata < ActiveRecord::Migration
  def self.up
    add_column :storydatas, :who_id, :integer
    add_index :storydatas, :who_id
    remove_column :posts, :who_id
  end

  def self.down
    add_column :posts, :who_id, :integer
    add_index :posts, :who_id
    remove_column :storydatas, :who_id
    remove_index :storydatas, :who_id
  end
end
