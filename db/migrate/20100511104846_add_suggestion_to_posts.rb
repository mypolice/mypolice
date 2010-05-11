class AddSuggestionToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :suggestion, :text
  end

  def self.down
    remove_column :posts, :suggestion
  end
end
