class AddIscheifToPolices < ActiveRecord::Migration
  def self.up
    add_column "polices", "ischeif", :boolean, :default => false
    add_index "polices", "ischeif"
  end

  def self.down
    remove_column "polices", "ischeif", :boolean
    remove_index "polices", "ischeif"
  end
end
