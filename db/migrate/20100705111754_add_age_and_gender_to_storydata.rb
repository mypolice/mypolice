class AddAgeAndGenderToStorydata < ActiveRecord::Migration
  def self.up
    add_column :storydatas, :gender, :integer
    add_column :storydatas, :age, :integer
  end

  def self.down
    remove_column :storydatas, :gender
    remove_column :storydatas, :age
  end
end
