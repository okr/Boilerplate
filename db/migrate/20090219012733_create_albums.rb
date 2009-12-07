class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
		t.string :title
		t.string :description
		t.string :cached_slug
		t.references :user

		t.timestamps
	end

  end

  def self.down
    drop_table :albums
  end
end
