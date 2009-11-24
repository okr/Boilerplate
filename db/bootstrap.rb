Bootstrapper.for :users do |b|
  admin_role = Role.new
  admin_role.name = "admin"
  admin_role.save

  admin_user = User.new
  admin_user.login = "admin"
  admin_user.name = Settings.admin_name
  admin_user.email = Settings.admin_email
  admin_user.password = Settings.admin_password
  admin_user.password_confirmation = Settings.admin_password
  admin_user_role = Role.find_by_name("admin")
  admin_user.role_id = admin_user_role.id
  
  if admin_user.save!
    puts "Admin Account Created"
  else
    puts "#{admin_user.errors}"
  end
  
  default_role = Role.new
  default_role.name = "default"
  default_role.save
  
  default_user = User.new
  default_user.login = "default"
  default_user.name = Settings.default_user_name
  default_user.email = Settings.default_user_email
  default_user.password = Settings.default_user_password
  default_user.password_confirmation = Settings.default_user_password
  default_user_role = Role.find_by_name("default")
  default_user.role_id = default_user_role.id
  
  if default_user.save!
    puts "Default User Account Created"
  else
    puts "#{default_user.errors}"
  end

end

Bootstrapper.for :pages do |p|
	
	admin = User.admins.first
	
	c = PageCategory.new
	c.title = 'Default'
	c.tagline = 'Default tagline'
	
	if c.save!
		puts "#{c.position} #{c.title} #{c.type} Category Created"
	else
		puts "#{c.errors}"
	end
	
	c_two = PageCategory.new
	c_two.title = 'Default Two'
	c_two.tagline = 'Default two tagline'
	
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
	page.user_id = admin.id

	page.page_categories = [c]
	
	if page.save!
		puts "#{page.name} Page Created"
	else
		puts "#{page.errors}"
	end
	
	page = Page.new
	page.title = 'About Us'
	page.name = 'About'
	page.body = '<p>About this site.</p>'
	page.published = true
	page.home = true
	page.user_id = admin.id

	page.page_categories = [c, c_two]
	
	if page.save!
		puts "#{page.name} Page Created"
		puts "Added to Page Categories - #{page.page_categories}"
	else
		puts "#{page.errors}"
	end
	
end

Bootstrapper.for :links do |b|
	
	c = LinkCategory.new
	c.title = 'Default'
	c.tagline = 'Default link category tagline'
	
	if c.save!
		puts "#{c.position} #{c.title} #{c.type} Category Created."
	else
		puts "#{c.errors}"
	end
	
	c_two = LinkCategory.new
	c_two.title = 'Default Two'
	c_two.tagline = 'Default two tagline'
	
	if c_two.save!
		puts "#{c_two.position} #{c_two.title} #{c_two.type} Category Created"
	else
		puts "#{c_two.errors}"
	end
	
	default_link = Link.new
	default_link.title = 'Google'
	default_link.url = 'http://google.com'
	default_link.link_categories = [c, c_two]
	
	if default_link.save!
		puts "#{default_link.title} Created."
	else
		puts "#{default_link.errors}"
	end
	
	default_link = Link.new
	default_link.title = 'Public Site'
	default_link.url = Settings.domain
	default_link.admin = true
	
	if default_link.save!
		puts "#{default_link.title} Created."
	else
		puts "#{default_link.errors}"
	end
end

Bootstrapper.for :posts do |b|
	
	c = PostCategory.new
	c.title = 'Default'
	c.tagline = 'Default post category tagline'
	
	if c.save!
		puts "#{c.position} #{c.title} #{c.type} Category Created."
	else
		puts "#{c.errors}"
	end
	
	c_two = PostCategory.new
	c_two.title = 'Default Two'
	c_two.tagline = 'Default two tagline'
	
	if c_two.save!
		puts "#{c_two.position} #{c_two.title} #{c_two.type} Category Created"
	else
		puts "#{c_two.errors}"
	end
	
	post = Post.new
	post.title = 'default'
	post.published = true
	post.body = "<p>Welcome to this site.  This is the first blog post.</p>"
	post.post_categories = [c, c_two]
	post.tag_list = ["Test Tag, Test Tag Two"]
	
	if post.save!
		puts "Default Post Created."
	else
		puts "#{post.errors}"
	end
end

