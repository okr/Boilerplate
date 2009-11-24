class CreatePhotos < ActiveRecord::Migration
	def self.up
		create_table :photos do |t|
			t.string   :title
			t.string   :caption
			t.integer  :position
			t.string   :image_file_name
			t.string   :image_content_type
			t.integer  :image_file_size
			t.datetime :image_updated_at
			t.integer  :photos_count, :default => 0
			t.references :album

		t.timestamps
	end

		add_index :photos, :position
	end

	def self.down
		drop_table :photos
	end
end