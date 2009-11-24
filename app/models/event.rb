class Event < ActiveRecord::Base
	named_scope :upcoming, :conditions => ["start >= ?", Date.today]
	named_scope :recent, :conditions => ["created_at || updated_at >= ?", 1.month.ago], :order => "created_at DESC", :limit => 10

	validates_presence_of :title, :message => ": Event title cannot be left blank."
	validates_presence_of :description, :message => ": Event description cannot be left blank."
	validates_presence_of :start, :message => ": Event start date cannot be left blank."
	validates_presence_of :end, :message => ": Event end date cannot be left blank."
	validates_uniqueness_of :title, :message => ": Article title has alreday been taken."
	validates_length_of :title, :within => 2..70, :too_long => ": Please pick a shorter title.", :too_short => ": Please pick a longer title"
	
	has_many :albums, :as => :attachable, :dependent => :destroy

	#has_many :category_items, :as => :item, :dependent => :destroy
	#has_many :event_categories, :through => :category_items, :source => :category, :source_type => 'EventCategory', :uniq => true, :dependent => :destroy
	
	belongs_to :event_category
	
	belongs_to :user

	has_friendly_id :title, :use_slug => true, :strip_diacritics => true
	
	fires :new_event, :on => [:create, :update], :actor => :user

end
