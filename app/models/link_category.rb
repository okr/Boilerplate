class LinkCategory < Category
	sortable :order => :position
	
	has_friendly_id :title, :use_slug => true, :strip_diacritics => true
	
	belongs_to :user
	
	fires :new_link_category, :on => [:create, :update], :actor => :user
	
	has_many :links, :source_type => 'Link', :uniq => true
end
