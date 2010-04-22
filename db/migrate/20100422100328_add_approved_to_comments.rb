class AddApprovedToComments < ActiveRecord::Migration
  def self.up
    add_column "comments", "approved", :boolean, :default => false
    add_index "comments", "approved"
  end

  def self.down
    remove_column "comments","approved", :boolean
    remove_index "cooments", "approved"
  end
end
