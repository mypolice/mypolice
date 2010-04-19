class AddPoliceIdToResponses < ActiveRecord::Migration
  def self.up
    add_column :responses, :police_id, :integer
  end

  def self.down
    remove_column :responses, :police_id
  end
end
