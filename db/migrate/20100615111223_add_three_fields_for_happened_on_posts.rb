class AddThreeFieldsForHappenedOnPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :happened_on_year, :date
    add_column :posts, :happened_on_month,:date
    add_column :posts, :happened_on_day,:date
  end

  def self.down
    remove_column :posts, :happened_on_year
    remove_column :posts, :happened_on_month
    remove_column :posts, :happened_on_day
  end
end
