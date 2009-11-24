class Admin::AlbumsController < ApplicationController
	before_filter :require_admin_user, :load_search, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'
	
	current_tab :photos

	def index
		session[:return_to] = request.request_uri
		@album_results = @album_search.all.paginate :page => params[:search_page], :per_page => 12
		@album = Album.new

		respond_to do |format|
			format.html
			format.js { render :partial => "search_results", :layout => false }
		end
	end
  
	def show
		session[:return_to] = request.request_uri
		@album_results = @album_search.all.paginate :page => params[:search_page], :per_page => 12
		@album = Album.find(params[:id])
		@albums = Album.find(:all).paginate :page => params[:albums_page], :per_page => 12
		@photos = @album.photos
		@page_title << " - " + @album.title
	  
		respond_to do |format|
			format.html
			format.js
			format.xml	{ render :xml => @album.to_xml }
		end
	end

	def new
		session[:return_to] = request.request_uri
		@album_results = @album_search.all.paginate :page => params[:search_page], :per_page => 12
		@album = Album.new
		@albums = Album.find(:all).paginate :page => params[:albums_page], :per_page => 12
		@album.photos.build
		@page_title << " - Create A New Album"

		respond_to do |format|
			format.html
			format.js {
				@album = Album.new
				render :layout => false 
			}
		end
	end

	def create
		@album = Album.new(params[:album])
		
		@album.user = current_user

		respond_to do |format|
			if @album.save		
				flash[:notice] = 'Album was successfully created.'
				format.html { redirect_to admin_album_url(@album) }
				format.js { render :partial => "album_results", :layout => false }
			else
				@album_search = Album.search(params[:search])
				@album_results = @album_search.all.paginate :page => params[:search_page], :per_page => 12
				@page_title << " - Create A New Album"

				flash[:alert] = 'Album could not be created.'
				format.html { render :action => "new" }
				format.js
			end
		end
	end

	def edit
		session[:return_to] = request.request_uri
		@album_results = @album_search.all.paginate :page => params[:search_page], :per_page => 12
		@album = Album.find(params[:id])
		@albums = Album.find(:all).paginate :page => params[:albums_page], :per_page => 12
		@page_title << " - Editing - " + @album.title

		respond_to do |format|
			format.html
			format.js {
				@album = Album.new
				render :layout => false 
			}
		end
	end

	def update
		@album = Album.find(params[:id])
		
		@album.user = current_user

		respond_to do |format|
			if @album.update_attributes(params[:album])
				flash[:notice] = 'Album was successfully updated.'
				format.html { redirect_to admin_album_url(@album) }
			else
				@album_search = Album.search(params[:search])
				@album_results = @album_search.all.paginate :page => params[:search_page], :per_page => 12
				@albums = Album.find(:all).paginate :page => params[:albums_page], :per_page => 12
				@page_title << " - Editing - " + @album.title
				flash[:alert] = 'Album was not successfully updated.'
				format.html { render :action => "edit" }
			end
		end
	end
  
	def destroy
		@album = Album.find(params[:id])
		@album.destroy
	
		respond_to do |format|
			flash[:notice] = 'Album was successfully deleted.'
			format.html { redirect_to admin_albums_url }
		end
	end
  
	def higher
		album = Album.find(params[:id])
		unless album.nil?
			if album.first_item?
				album.move_to_bottom!
			else
				album.move_up!
			end
		end
		respond_to do |format|
			flash[:notice] = "Album posiition changed successfully."
			format.html { redirect_back_or_default(admin_albums_url) }
		end
	end

	def lower
		album = Album.find(params[:id])
		unless album.nil?
			if album.last_item?
				album.move_to_top!
			else
				album.move_down!
			end
		end
		
		respond_to do |format|
			flash[:notice] = "Album posiition changed successfully."
			format.html { redirect_back_or_default(admin_albums_url) }
		end
	end
  
	def top
		album = Album.find(params[:id])
		unless album.nil?
		  unless album.first_item?
			album.move_to_top!
		  else
			album.move_down!
		  end
		end
	
		respond_to do |format|
			flash[:notice] = "Album posiition changed successfully."
			format.html { redirect_back_or_default(admin_albums_url) }
		end
	end
  
	def bottom
		album = Album.find(params[:id])
		unless album.nil?
			unless album.last_item?
				album.move_to_bottom!
			else
				album.move_up!
			end
		end

		respond_to do |format|
			flash[:notice] = "Album posiition changed successfully."
			format.html { redirect_back_or_default(admin_albums_url) }
		end
	end
	
	def page_title
		@page_title = []
		@page_title << "Albums"
	end
	
	def load_search
		@album_search = Album.search(params[:search])
	end
end
