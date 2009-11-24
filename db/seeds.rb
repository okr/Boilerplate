# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

	# Users

	admin_role = Role.new
	admin_role.name = "admin"
	#admin_role.save
	
	if admin_role.save!
		puts "Admin Role Created"
	else
		puts "#{admin_role.errors}"
	end
	
	admin_user = User.new
	admin_user.login = "admin"
	admin_user.name = Settings.admin_name
	admin_user.email = Settings.admin_email
	admin_user.password = Settings.admin_password
	admin_user.password_confirmation = Settings.admin_password
	admin_user_role = Role.find_by_name("admin")
	admin_user.role_id = admin_user_role.id
	admin_user.profile = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
	
	if admin_user.save!
		puts "Admin Account Created"
	else
		puts "#{admin_user.errors}"
	end
	
	public_role = Role.new
	public_role.name = "public"
    #public_role.save
	
	if public_role.save!
		puts "Public Role Created"
	else
		puts "#{public_role.errors}"
	end
	
	public_user = User.new
	public_user.login = "public"
	public_user.name = Settings.public_user_name
	public_user.email = Settings.public_user_email
	public_user.password = Settings.public_user_password
	public_user.password_confirmation = Settings.public_user_password
	public_user_role = Role.find_by_name("public")
	public_user.role_id = public_user_role.id
	public_user.profile = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
	
	if public_user.save!
		puts "Public User Account Created"
	else
		puts "#{public_user.errors}"
	end
	
	publisher_role = Role.new
	publisher_role.name = "publisher"
	publisher_role.save
	
	if publisher_role.save!
		puts "Publisher Role Created"
	else
		puts "#{publisher_role.errors}"
	end
	
	publisher_user = User.new
	publisher_user.login = "publisher"
	publisher_user.name = Settings.publisher_user_name
	publisher_user.email = Settings.publisher_user_email
	publisher_user.password = Settings.publisher_user_password
	publisher_user.password_confirmation = Settings.publisher_user_password
	publisher_user_role = Role.find_by_name("publisher")
	publisher_user.role_id = publisher_user_role.id
	publisher_user.profile = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
	
	if publisher_user.save!
		puts "Publisher User Account Created"
	else
		puts "#{publisher_user.errors}"
	end
	
	# Pages
	
	c = PageCategory.new
	c.title = 'Default'
	c.tagline = 'Default tagline'
	c.user = admin_user
	
	if c.save!
		puts "#{c.position} #{c.title} #{c.type} Category Created"
	else
		puts "#{c.errors}"
	end
	
	c_two = PageCategory.new
	c_two.title = 'Default Two'
	c_two.tagline = 'Default two tagline'
	c_two.user = admin_user
	
	if c_two.save!
		puts "#{c_two.position} #{c_two.title} #{c_two.type} Category Created"
	else
		puts "#{c_two.errors}"
	end

	page = Page.new
	page.title = 'Home Page'
	page.name = 'Home'
	page.body = '<p>At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat.</p>'
	page.published = true
	page.home = true
	page.user = admin_user

	page.page_category = c
	
	if page.save!
		puts "#{page.name} Page Created"
		puts "Added to Page Category - #{page.page_category.title}"
	else
		puts "#{page.errors}"
	end
	
	page = Page.new
	page.title = 'About Us'
	page.name = 'About'
	page.body = '<p>About this site.</p>'
	page.published = true
	page.home = true
	page.user = admin_user
	
	#Page Categories

	page.page_category = c_two
	
	if page.save!
		puts "#{page.name} Page Created"
		puts "Added to Page Category - #{page.page_category.title}"
	else
		puts "#{page.errors}"
	end
	
	# Link Categories
	
	c = LinkCategory.new
	c.title = 'Default Link Category'
	c.tagline = 'Default link category tagline'
	c.user = admin_user
	
	if c.save!
		puts "#{c.position} #{c.title} #{c.type} Category Created."
	else
		puts "#{c.errors}"
	end
	
	c_two = LinkCategory.new
	c_two.title = 'Default Link Category Two'
	c_two.tagline = 'Default two tagline'
	c_two.user = admin_user
	
	if c_two.save!
		puts "#{c_two.position} #{c_two.title} #{c_two.type} Category Created"
	else
		puts "#{c_two.errors}"
	end
	
	default_link = Link.new
	default_link.title = 'Google'
	default_link.url = 'http://google.com'
	default_link.admin = false
	default_link.link_category = c
	default_link.user = admin_user
	
	if default_link.save!
		puts "#{default_link.title} Created."
		puts "Added to Link Category - #{default_link.link_category.title}"
	else
		puts "#{default_link.errors}"
	end
	
	default_link_two = Link.new
	default_link_two.title = 'Public Site'
	default_link_two.url = Settings.domain
	default_link_two.admin = true
	default_link_two.link_category = c_two
	default_link_two.user = admin_user
	
	if default_link_two.save!
		puts "#{default_link_two.title} Created."
		puts "Added to Link Category - #{default_link_two.link_category.title}"
	else
		puts "#{default_link_two.errors}"
	end
	
	# Posts
	
	c = PostCategory.new
	c.title = 'Default'
	c.tagline = 'Default post category tagline'
	c.user = admin_user
	
	if c.save!
		puts "#{c.position} #{c.title} #{c.type} Category Created."
	else
		puts "#{c.errors}"
	end
	
	c_two = PostCategory.new
	c_two.title = 'Default Two'
	c_two.tagline = 'Default two tagline'
	c_two.user = admin_user
	
	if c_two.save!
		puts "#{c_two.position} #{c_two.title} #{c_two.type} Category Created"
	else
		puts "#{c_two.errors}"
	end
	
	post = Post.new
	post.title = 'Welcome'
	post.published = true
	post.body = "<p>Welcome to this site.  This is the first blog post.</p>"
	post.post_category = c_two
	post.tag_list = "Test Tag, Test Tag Two"
	post.user = admin_user
	
	if post.save!
		puts "Welcome Post Created."
		puts "Added to Post Category - #{post.post_category.title}"
	else
		puts "#{post.errors}"
	end
	
	post_two = Post.new
	post_two.title = 'News'
	post_two.published = true
	post_two.body = "<p>News!  This is the second blog post.</p>"
	post_two.post_category = c_two
	post_two.tag_list = "Test Tag, Test Tag Two"
	post_two.user = admin_user
	
	if post_two.save!
		puts "News Post Created."
		puts "Added to Post Category - #{post_two.post_category.title}"
	else
		puts "#{post_two.errors}"
	end
