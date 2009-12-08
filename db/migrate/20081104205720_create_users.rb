class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
		t.string    :login,               :null => false
		t.string    :name
		t.text      :profile 
		t.string    :email, :string, :default => "", :null => false
		t.string    :crypted_password,    :null => false
		t.string    :password_salt,       :null => false                
		t.string    :remember_token
		t.string    :password_reset_token, :default => "", :null => false
		t.string    :persistence_token,   :null => false
		t.string    :single_access_token, :null => false
		t.string    :perishable_token,    :null => false
		t.integer   :login_count,         :null => false, :default => 0
		t.integer   :failed_login_count,  :null => false, :default => 0
		t.datetime  :last_request_at
		t.datetime  :current_login_at
		t.datetime  :last_login_at
		t.string    :current_login_ip
		t.string    :last_login_ip
		t.references   :role
		t.string :cached_slug

      t.timestamps
    end
    
    add_index :users, :password_reset_token
    add_index :users, :email
    add_index :users, :login
    add_index :users, :name
  end

  def self.down
    drop_table :users
  end
end
