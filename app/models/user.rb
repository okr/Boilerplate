class User < ActiveRecord::Base
	named_scope :recent, :conditions => ["created_at || updated_at >= ?", 1.month.ago], :order => "created_at DESC", :limit => 10
	named_scope :admins, :conditions => { :role_id => 1}

	validates_presence_of :name, :message => ": User name cannot be blank."
	validates_uniqueness_of :name, :message => ": User name already taken."
	validates_length_of :name, :within => 3..40, :too_long => ": Please pick a shorter user name.", :too_short => ": Please pick a longer user name"

	validates_presence_of     :login, :message => ": User login cannot be blank."
	validates_length_of       :login, :within => 3..40, :too_long => ": Please pick a shorter user login.", :too_short => ": Please pick a longer user login"
	validates_uniqueness_of   :login, :message => ": User login already taken."

	validates_presence_of     :email, :message => ": User email cannot be blank."
	validates_uniqueness_of   :email, :message => ": User email already taken."
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
	
	validates_length_of :profile, :within => 2..1500, :too_long => ": Please pick a shorter profile.", :too_short => ": Please pick a longer profile"

	validates_presence_of :role_id, :message => ": User must be assigned to a role."

	acts_as_authentic

	has_friendly_id :login, :use_slug => true, :strip_diacritics => true
	
	has_many :albums
	has_many :events
	has_many :event_categories
	has_many :links
	has_many :link_categories
	has_many :pages
	has_many :page_categories
	has_many :posts
	has_many :post_categories

	has_one :photo, :dependent => :destroy, :as => :attachable
	
	accepts_nested_attributes_for :photo, :allow_destroy => true

	belongs_to :role
	
	attr_accessor :role_name
	
	def deliver_password_reset_instructions!
		reset_perishable_token!
		UserMailer.deliver_password_reset_instructions(self)
	end

	def role_name
		Role.find(self.role_id).name
	end

end