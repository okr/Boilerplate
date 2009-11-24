class Page < ActiveRecord::Base
	sortable :order => :position

	named_scope :published, :conditions => {:published => true}, :order => :position
	named_scope :homepage, :conditions => {:home => true}
	named_scope :recent, :conditions => ["created_at || updated_at >= ?", 1.month.ago], :order => "created_at DESC", :limit => 10
	named_scope :in_category, :joins => :page_category, :conditions => ["page_categories.id = ?", id]

	validates_presence_of :title, :message => ": Page title cannot be left blank."
	validates_presence_of :name, :message => ": Page name cannot be left blank."
	validates_presence_of :body, :message => ": Page body cannot be left blank."
	validates_uniqueness_of :title, :message => ": This title has been taken.."
	validates_uniqueness_of :name, :message => ": This name has been taken.."
	validates_length_of :title, :within => 2..150, :too_long => ": Please pick a shorter title.", :too_short => ": Please pick a longer title"
	validates_length_of :name, :within => 2..40, :too_long => ": Please pick a shorter name.", :too_short => ": Please pick a longer name"
	validates_exclusion_of :title, :name, :in => ["admin, administrator, public, publisher"], :message => ": That name is reserved, please choose another."
	
	#has_many :category_items, :as => :item, :dependent => :destroy
	#has_many :page_categories, :through => :category_items, :source => :category, :source_type => "PageCategory", :uniq => true
	
	belongs_to :page_category

	accepts_nested_attributes_for :page_category, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
	
	has_many :albums, :as => :attachable
	has_many :photos, :through => :albums
	
	belongs_to :user

	has_friendly_id :title, :use_slug => true, :strip_diacritics => true
	
	fires :new_page, :on => [:create, :update], :actor => :user

end