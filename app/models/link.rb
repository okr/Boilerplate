class Link < ActiveRecord::Base
	named_scope :recent, :conditions => ["created_at || updated_at >= ?", 1.month.ago], :order => "created_at DESC", :limit => 10
	named_scope :admin_links, :conditions => {:admin => true}
	named_scope :public_links, :conditions => {:admin => false}

	validates_presence_of :title, :message => ": Link title cannot be blank."
	validates_uniqueness_of :title, :message => ": Link title already taken."
	validates_length_of :title, :within => 2..60, :too_long => ": Please pick a shorter link title.", :too_short => ": Please pick a longer link title"
	validates_exclusion_of :title, :in => ["admin, administrator, public, publisher"], :message => ": That name is reserved, please choose another."
	validates_url_of :url, :message => "is not valid or not responding."
	validates_presence_of :url, :message => ": Link url cannot be blank."
	validates_uniqueness_of :url, :message => ": Link url already taken."
	
	#has_many :category_items, :as => :item, :dependent => :destroy
	#has_many :link_categories, :through => :category_items, :source => :category, :source_type => 'LinkCategory', :uniq => true, :dependent => :destroy
	
	belongs_to :link_category
	
	belongs_to :user

	has_friendly_id :title, :use_slug => true, :approximate_ascii => true
	
	fires :new_link, :on => [:create, :update], :actor => :user
	
end
