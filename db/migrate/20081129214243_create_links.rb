class CreateLinks < ActiveRecord::Migration
	def self.up
		create_table :links do |t|
			t.string :title
			t.string :url
			t.boolean :admin, :default => false
			t.references :user
			t.string :cached_slug
			t.references :link_category

			t.timestamps
		end

		add_index :links, :admin
		add_index :links, :user_id
	end

	def self.down
		drop_table :links
	end
end
