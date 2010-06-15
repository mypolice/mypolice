class RemoveHappenedOnPosts < ActiveRecord::Migration
  def self.up
    remove_column :posts, :happened_on
  end

  def self.down
    add_column :posts, :happened_on, :date
  end
end
