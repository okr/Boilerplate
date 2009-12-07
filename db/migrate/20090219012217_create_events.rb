class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
		t.string :title
		t.string :location
		t.string :street
		t.string :city_town
		t.string :description
		t.datetime :start
		t.datetime :end
		t.string :cached_slug
		t.references :user
		t.references :event_category
		
      t.timestamps
    end

	add_index :events, :start
	add_index :events, :end
	add_index :events, :user_id
  end

  def self.down
    drop_table :events
  end
end
