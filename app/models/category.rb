class Category < ActiveRecord::Base	
	
	validates_uniqueness_of :title, :message => ": Title already taken.", :scope => :type
	validates_presence_of :title, :message => ": Title cannot be blank."
	validates_length_of :title, :within => 2..60, :too_long => ": Please pick a shorter title.", :too_short => ": Please pick a longer page category title"
	validates_length_of :tagline, :within => 2..90, :too_long => ": Please pick a shorter tagline.", :too_short => ": Please pick a longer tagline"
	validates_exclusion_of :title, :in => ["admin, administrator, public, publisher"], :message => ": That name is reserved, please choose another."
	
	def blank?
		title.blank? and tagline.blank?
	end
end