class Role < ActiveRecord::Base
  validates_presence_of :name, :message => ": Role title cannot be blank."
  validates_uniqueness_of :name, :message => ": Role title already taken."
  validates_length_of :name, :within => 2..60, :too_long => ": Please pick a shorter role title.", :too_short => ": Please pick a longer role title"
  
  has_many :users
  
end
