class AddCrimeToStorydata < ActiveRecord::Migration
  def self.up
    add_column :storydatas, :crimenumber, :string 
  end

  def self.down
    remove_column :storydatas, :crimenumber, :string
  end
end
