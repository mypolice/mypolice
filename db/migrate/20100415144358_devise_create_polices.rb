class DeviseCreatePolices < ActiveRecord::Migration
  def self.up
    create_table(:polices) do |t|
      t.database_authenticatable :null => false
     # t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

      t.timestamps
    end
    add_column :polices, :name, :string
    add_index :polices, :email,                :unique => true
    #add_index :polices, :confirmation_token,   :unique => true
    add_index :polices, :reset_password_token, :unique => true
    # add_index :polices, :unlock_token,         :unique => true
    
  end

  def self.down
    drop_table :polices
  end
end
