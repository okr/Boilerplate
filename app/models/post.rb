class Post < ActiveRecord::Base
    acts_as_taggable_on :tags

	named_scope :published, :conditions => {:published => true}
	named_scope :recent, :conditions => ["created_at || updated_at >= ?", 1.month.ago], :order => "created_at DESC", :limit => 10

	validates_presence_of :title, :message => ": Post title cannot be left blank."
	validates_presence_of :body, :message => ": Post body cannot be left blank."
	validates_uniqueness_of :title, :message => ": This title has been taken.."
	validates_length_of :title, :within => 2..70, :too_long => ": Please pick a shorter title.", :too_short => ": Please pick a longer title"
	validates_exclusion_of :title, :in => ["admin, administrator, public, publisher"], :message => ": That name is reserved, please choose another."
	
	belongs_to :post_category
	
	belongs_to :user

	has_friendly_id :title, :use_slug => true, :approximate_ascii => true
	
	fires :new_post, :on => [:create, :update], :actor => :user

end