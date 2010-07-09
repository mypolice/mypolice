class CreateStorydatas < ActiveRecord::Migration
  def self.up
    create_table :storydatas do |t|
      t.boolean :contact
      t.integer :contactway
      t.integer :easeofcontactingrating
      t.integer :afterreport
      t.boolean :isreport
      t.integer :howlongarrivetold
      t.integer :howlongarrive
      t.integer :arriverating

      t.integer :isexplain
      t.integer :isinvestigate
      t.integer :referenceno
      t.integer :contactdetail
      t.integer :actionrating

      t.boolean :anycontact
      t.boolean :furthercontact
      t.boolean :contact_a
      t.boolean :contact_b
      t.boolean :contact_c
      t.boolean :contact_d
      t.boolean :contact_e
      t.boolean :contact_f
      t.boolean :contact_g
      t.boolean :contact_h
      t.integer :keepinformrating

      t.integer :islisten
      t.integer :issympathetically
      t.integer :isinterested
      t.integer :ispolitely
      t.integer :understand
      t.integer :isseriously
      t.integer :discourage
      t.integer :treatmentrating

      t.integer :wholerating
      
      t.timestamps
    end
  end

  def self.down
    drop_table :storydatas
  end
end
