class Album < ActiveRecord::Base
	validates_uniqueness_of :title, :message => ": Title already taken."
	validates_presence_of :title, :message => ": Title cannot be blank."
	validates_length_of :title, :within => 2..60, :too_long => ": Please pick a shorter title.", :too_short => ": Please pick a longer title"
	validates_exclusion_of :title, :in => ["admin, administrator, public, publisher"], :message => ": That name is reserved, please choose another."
	validates_length_of :description, :within => 0..120, :too_long => ": Please pick a shorter description.", :too_short => ": Please pick a longer description"
	
	belongs_to :attachable, :polymorphic => true
	has_many :photos, :dependent => :destroy
	
	belongs_to :user
	
	has_friendly_id :title, :use_slug => true, :strip_diacritics => true
	
	fires :new_album, :on => [:create, :update], :actor => :user
	
	accepts_nested_attributes_for :photos, :allow_destroy => true
	
	def main_photo(attribute)
		if photo = self.photos.first rescue nil
			if attribute == :title
				photo.title
			elsif attribute == :caption
				photo.caption
			else
				photo.image.url(attribute)
			end
		else
			"/images/missing_image_#{(attribute).to_s}.png"
		end	
	end
	
	def after_save
		if self.photos[0].title == "" and self.photos[0].caption == "" and self.photos[0].image == nil
			self.photos[0].delete
		end
	end
	
	def setup_photos(album)
	  returning(album) do |a|
	    a.photos.build
	  end
	end
end
