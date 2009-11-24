class CreateCategories < ActiveRecord::Migration
	def self.up
		create_table :categories do |t|
			t.string :title
			t.string :tagline
			t.integer :position
			t.references :user
			t.string :type
			
			t.timestamps
		end
		
		add_index :categories, :position
		
		
		
		# create_table :category_items do |t|
		# 	t.references :category, :polymorphic => true
		# 	t.references :item, :polymorphic => true
		# 	
		# 	t.timestamps
		# end
		# 
		# add_index :category_items, [:category_id, :category_type]
		# add_index :category_items, [:item_id, :item_type]
	end

	def self.down
		drop_table :categories
		#drop_table :category_items
	end
end
