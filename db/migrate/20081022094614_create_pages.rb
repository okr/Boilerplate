class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
		t.string :name
		t.string :title
		t.text :body
		t.integer :position
		t.boolean :published, :default => false
		t.boolean :home, :default => false
		t.references :user
		t.references :page_category

      t.timestamps
    end
    
    add_index :pages, :position
	add_index :pages, :published
	add_index :pages, :home
	add_index :pages, :user_id
  end

  def self.down
    drop_table :pages
  end
end
