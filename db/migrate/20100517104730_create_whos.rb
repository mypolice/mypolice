class CreateWhos < ActiveRecord::Migration
  def self.up
    create_table :whos do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :whos
  end
end
