class Attachment < ActiveRecord::Base

    sortable :order => :position, :scope => [:attachable_id, :attachable_type]
    
    belongs_to :attachable, :polymorphic => true
    
    validates_presence_of :title, :message => ": Attachment title cannot be blank."
	validates_uniqueness_of :title, :message => ": Attachment title already taken."
	validates_length_of :title, :within => 2..60, :too_long => ": Please pick a shorter attachment title.", :too_short => ": Please pick a longer attachment title"
	validates_exclusion_of :title, :in => ["admin, administrator"], :message => ": That name is reserved, please choose another."
	
	validates_attachment_presence(:data, :message => ": You need to include a data file to upload an attachment." )                  
	#validates_attachment_content_type(:data, { :content_type => [ 'image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg' ] })
	validates_attachment_size(:data, { :in => 0.06..1.5.megabyte, :message => ": All attachment files must be larger than 60k and smaller than 1.5 megabytes."})

	has_attached_file :data
    
end
