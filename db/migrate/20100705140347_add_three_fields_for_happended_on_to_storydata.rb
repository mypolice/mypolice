class AddThreeFieldsForHappendedOnToStorydata < ActiveRecord::Migration
  def self.up
    add_column :storydatas, :happened_on_year, :date
    add_column :storydatas, :happened_on_month,:date
    add_column :storydatas, :happened_on_day,:date
  end

  def self.down
    remove_column :storydatas, :happended_on_year
    remove_column :storydatas, :happended_on_month
    remove_column :storydatas, :happended_on_day
  end
end
