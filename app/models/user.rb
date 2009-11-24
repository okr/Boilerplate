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

	belongs_to :role
	
	attr_accessor :role_name
	
	has_attached_file :avatar, :styles => {
								:small => {:geometry => "100x100#", :processors => [:cropper]},
								:large => {:geometry => "500x500>"}
							},
								:default_url => "/images/missing_image_:style.png",
								:whiny_thumbnails => true
                 
	validates_attachment_content_type(:avatar, { :content_type => [ 'image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg' ] })
	validates_attachment_size(:avatar, { :in => 0.06..1.5.megabyte, :message => ": All image files must be larger than 60k and smaller than 1.5 megabytes."})
	
	attr_protected :avatar_file_name, :avatar_content_type, :avatar_size
	attr_accessor :x, :y
	after_update :reprocess_avatar, :if => :cropping?
	

	def deliver_password_reset_instructions!
		reset_perishable_token!
		UserMailer.deliver_password_reset_instructions(self)
	end

	def role_name
		Role.find(self.role_id).name
	end
	
	def cropping?  
        !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?  
    end
    
    def self.x
        unless crop_x.blank?
            return '0'
        end
    end
    
    def self.y
        unless crop_y.blank?
            return '0'
        end
    end

    def avatar_geometry(style = :original)
        @geometry ||= {}
        @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
    end

    private

    def reprocess_avatar
        avatar.reprocess!
    end

end