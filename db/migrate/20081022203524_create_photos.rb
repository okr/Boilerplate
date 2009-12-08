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
			t.integer :crop_x
    		t.integer :crop_y
    		t.integer :crop_w
    		t.integer :crop_h
			t.references :attachable, :polymorphic => true
			#t.references :album
			#t.references :user

		t.timestamps
	end

		add_index :photos, :position
		add_index :photos, [:attachable_id, :attachable_type]
	end

	def self.down
		drop_table :photos
	end
end