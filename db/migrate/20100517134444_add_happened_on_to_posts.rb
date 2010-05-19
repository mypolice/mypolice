class AddHappenedOnToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :happened_on, :date
  end

  def self.down
    remove_column :posts, :happened_on
  end
end
