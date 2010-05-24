class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.text :address_line1
      t.text :address_line2
      t.text :city
      t.text :county
      t.text :postcode
      t.text :country

    end
  end

  def self.down
    drop_table :addresses
  end
end
