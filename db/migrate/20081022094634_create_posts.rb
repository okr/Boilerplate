class CreatePosts < ActiveRecord::Migration
	def self.up
		create_table :posts do |t|
			t.string :title
			t.text :body
			t.boolean :published, :default => false
			t.references :user
			t.references :post_category

			t.timestamps
		end
    
    add_index :posts, :published
	add_index :posts, :user_id
  end

  def self.down
    drop_table :posts
  end
end
