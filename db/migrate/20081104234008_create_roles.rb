class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
    
    add_index :users, :role_id
    add_index :roles, :name   
  end

  def self.down
    drop_table :roles
  end
end
