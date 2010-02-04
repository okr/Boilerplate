class PageCategory < Category
	sortable :order => :position
	
	has_friendly_id :title, :use_slug => true, :approximate_ascii => true
	
	belongs_to :user
	
	fires :new_page_category, :on => [:create, :update], :actor => :user
	
	has_many :pages, :source_type => 'Page', :uniq => true
end
