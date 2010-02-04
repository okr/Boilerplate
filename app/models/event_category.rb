class EventCategory < Category
	sortable :order => :position

	has_friendly_id :title, :use_slug => true, :approximate_ascii => true
	
	belongs_to :user
	
	fires :new_event_category, :on => [:create, :update], :actor => :user
	
	has_many :events, :source_type => 'Event', :uniq => true
end
