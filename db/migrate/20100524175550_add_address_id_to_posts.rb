class AddAddressIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :address_id, :integer
    add_index :posts, :address_id
  end

  def self.down
    remove_column :posts, :address_id
    remove_index :posts, :address_id
  end
end
