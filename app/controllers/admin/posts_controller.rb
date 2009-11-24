class Admin::PostsController < ApplicationController
    auto_complete_for :tag, :name, :collection_instance_variable => :tags
	before_filter :require_admin_user, :load_search, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'
	
	current_tab :blog
  
  	def show
		session[:return_to] = request.request_uri
		@posts_results = @post_search.all
		@posts = Post.paginate :page => params[:blog_page], :per_page => 12
		@post = Post.find(params[:id])
		
		@page_title << " - " + @post.title

		respond_to do |format|
			format.html
			format.js
		end
	end

	def index
		session[:return_to] = request.request_uri
		@post_results = @post_search.all(:include => :tags).paginate :page => params[:blog_page], :per_page => 12
		
		respond_to do |format|
			format.html
			format.js { 
				render :partial => "search_results", :layout => false
			}
		end
	end

	def new
		session[:return_to] = request.request_uri
		@posts_results = @post_search.all
		@posts = Post.paginate :page => params[:blog_page], :per_page => 12
		@post = Post.new
		
		@page_title << " - Create A New Post"

		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@post = Post.new(params[:post])
		
		@post.user = current_user
		
		if params[:post][:home] == "1"
			for post in Post.homepost.all
				if post.home == true
					post.update_attributes(:home => "false")
				end
			end
			@post.update_attributes(:home => params[:home])
		end

		respond_to do |format|
			if @post.save       
				flash[:notice] = 'Post was successfully created.'
				format.html { redirect_to admin_post_url(@post) }
			else
				@post_search = Post.search(params[:search])
				@posts_results = @post_search.all
				@posts = Post.paginate :page => params[:blog_page], :per_page => 12
				@page_title << " - Create A New Link"
				flash[:alert] = 'Post could not be created.'
				format.html { render :action => "new" }
			end
		end
	end
	
	def edit
		session[:return_to] = request.request_uri
		@posts_results = @post_search.all
		@post = Post.find(params[:id])
		@posts = Post.paginate :page => params[:blog_page], :per_page => 12
		@page_title << " - Editing - " + @post.title

		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		params[:product][:photo_attributes] ||= {} unless params[:product].nil?

		@post = Post.find(params[:id])
		
		@post.user = current_user
		
		if params[:post][:home] == "1"
			for post in Post.homepost.all
				if post.home == true
					post.update_attributes(:home => "false")
				end
			end
			@post.update_attributes(:home => params[:home])
		end

		respond_to do |format|
			if @post.update_attributes(params[:post])
				flash[:notice] = 'Post was successfully updated.'
				format.html { redirect_to admin_post_url(@post) }
				format.js
			else
				@post_search = Post.search(params[:search])
				@posts_results = @post_search.all
				@posts = Post.paginate :page => params[:blog_page], :per_page => 12
				@page_title << " - Editing - " + @post.title
				flash[:alert] = 'Post was not successfully updated.'
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		respond_to do |format|
			flash[:notice] = 'Post was successfully deleted.'
			format.html { redirect_to admin_posts_url }
		end
	end
	
	def page_title
		@page_title = []
		
		@page_title << "Blog"
	end
	
	def load_search
		@categories = PostCategory.all
		@post_search = Post.search(params[:search])
		@tags = Tag.all
	end
  
end
