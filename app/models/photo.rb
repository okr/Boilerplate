class Photo < ActiveRecord::Base
	
	sortable :order => :position, :scope => [:attachable_id, :attachable_type]
	
	belongs_to :attachable, :polymorphic => true

	validates_presence_of :title, :message => ": Photo title cannot be blank."
	validates_uniqueness_of :title, :message => ": Photo title already taken."
	validates_length_of :title, :within => 2..60, :too_long => ": Please pick a shorter photo title.", :too_short => ": Please pick a longer photo title"
	#validates_length_of :caption, :within => 0..200, :too_long => ": Please pick a shorter photo caption.", :too_short => ": Please pick a longer photo caption"
	validates_exclusion_of :title, :in => ["admin, administrator"], :message => ": That name is reserved, please choose another."

	has_attached_file :image, :styles => {
								:small => {:geometry => "50x50#", :processors => [:cropper], :file_type => :jpg},
								:thumb=> {:geometry => "100x100#", :processors => [:cropper], :file_type =>  :jpg},
								:medium => {:geometry => "200x200#", :processors => [:cropper], :file_type =>  :jpg},
								:large => {:geometry => "300x300#", :processors => [:cropper], :file_type =>  :jpg},
								:large => {:geometry => "500x500>"}
							},
								:default_url => "/images/missing_image_:style.png",
								:whiny_thumbnails => true
								#:convert_options => { :all => "-quality 70" }

	validates_attachment_presence(:image, :message => ": You need to include an image file to upload a photo." )                  
	validates_attachment_content_type(:image, { :content_type => [ 'image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg' ] })
	validates_attachment_size(:image, { :in => 0.06..1.5.megabyte, :message => ": All image files must be larger than 60k and smaller than 1.5 megabytes."})
	
	is_taggable :tags

	#attr_protected :image_file_name, :image_content_type, :image_size
	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :x, :y
	after_update :reprocess_image, :if => :cropping?

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

    def image_geometry(style = :original)
        @geometry ||= {}
        @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
    end

    private

    def reprocess_image
        image.reprocess!
    end

end