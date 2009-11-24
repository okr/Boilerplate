class PostCategory < Category
	sortable :order => :position

	has_friendly_id :title, :use_slug => true, :strip_diacritics => true
	
	belongs_to :user
	
	fires :new_post_category, :on => [:create, :update], :actor => :user

	has_many :posts, :source_type => 'Post', :uniq => true
end
