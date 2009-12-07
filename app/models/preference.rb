class Preference < ActiveRecord::Base
    validates_presence_of :title, :message => ": Site title cannot be left blank."
	validates_presence_of :tagline, :message => ": Site tagline cannot be left blank."
	validates_uniqueness_of :title, :message => ": This site title has been taken.."
	validates_length_of :title, :within => 2..70, :too_long => ": Please pick a shorter title for your site.", :too_short => ": Please pick a longer title for your site."
	validates_length_of :tagline, :within => 2..70, :too_long => ": Please pick a shorter tagline for your site.", :too_short => ": Please pick a longer tagline for your site."
	validates_length_of :blog_title, :within => 2..70, :too_long => ": Please pick a shorter title for your blog.", :too_short => ": Please pick a longer title for your blog."
	
	belongs_to :user
	
	fires :new_preference, :on => [:create, :update], :actor => :user
end
