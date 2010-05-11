class AddCategoryIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :category_id, :integer
    add_index :posts, :category_id
  end

  def self.down
    remove_column :posts, :category_id, :integer
    remove_index :posts, :category_id
  end
end
