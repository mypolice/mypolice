class AddStorydataIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :storydata_id, :integer
    add_index :posts, :storydata_id    
  end

  def self.down
    remove_column :posts, :storydata_id
    remove_index :posts, :storydata_id    
  end
end
