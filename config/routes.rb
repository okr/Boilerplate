ActionController::Routing::Routes.draw do |map|

	map.root :controller => "home", :action => "index"

	map.login "login", :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"

	map.resource :user_session
	
	#Contact Form Routing
	map.contact "contact", :controller => "contact", :action => "new"
	map.resource :contact_form, :controller => "contact"
	
	#Static Page Routing
	map.resources :page, :only => [:index, :show], :shallow => true, :has_many => [:tags, :albums] 
	
	#Blog Routing
	map.resources :posts, :only => [:index, :show], :shallow => true, :path_prefix => "blog", :has_many => [:tags, :albums]
	
	#Calender Routing
	map.resources :events, :only => [:index, :show], :shallow => true, :path_prefix => "calendar", :has_many => [:tags, :albums]

	#Links Routing
	map.resources :links, :only => [:index, :show], :shallow => true, :has_many => [:tags, :albums]
	
	#Photo Routing
	map.resources :albums, :only => [:index, :show], :has_many => :photos
	
	#Jammit Asset Packaging Routing
    Jammit::Routes.draw(map)

	#Admin Area Routing
	map.namespace :admin do |admin|
		admin.root :controller => "dashboard", :action => "index"

		admin.resources :users, :collection => {
			:forgot_password => :get,
			:request_password_reset => :post,
			:edit_password => :get,
			:update_password => :put
		}, :member => { :crop => :get, :update_photo => :put }

		#Static Pages Routes
		admin.resources :pages, :member => { :higher => :put, :lower => :put, :top => :put, :bottom => :put }, :has_many => [:albums, :tags]
		
		#Photo Routing
		admin.resources :albums, :member => { :higher => :put, :lower => :put, :top => :put, :bottom => :put }, :has_many => :photos
		
		admin.resources :photos, :member => { :higher => :put, :lower => :put, :top => :put, :bottom => :put, :crop => :post }

		#Blog Routing
		admin.resources :posts, :has_many => [:albums, :tags]
		
		#Calender Routing
		admin.resources :events, :has_many => [:albums, :tags]

		#Links Routing
		admin.resources :links, :member => { :higher => :put, :lower => :put, :top => :put, :bottom => :put }
		
		#Tags Routing
		admin.resources :tags, :only => :index
		
		#Site Preferences Routing
	    admin.resources :preferences, :only => [:index, :show, :edit]
	end

end