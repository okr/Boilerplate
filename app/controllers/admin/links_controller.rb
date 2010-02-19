class Admin::LinksController < ApplicationController
	before_filter :require_admin_user, :load_search, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'

	current_tab :links

	def index
		@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6

		respond_to do |format|
			format.html
			format.js
		end
	end
  
	def show
		@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6
		@link = Link.find(params[:id])
		@links = Link.paginate :page => params[:links_page], :per_page => 6
		@page_title << " - " + @link.title
	  
		respond_to do |format|
			unless request.xhr?
				format.html
			else
				format.js { render :partial => "sidebar", :layout => false }
			end
		end
	end

	def new
		@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6
		@link = Link.new
		@links = Link.paginate :page => params[:links_page], :per_page => 6
		@page_title << " - Create A New Link"

		respond_to do |format|
			unless request.xhr?
				format.html
			else
				format.js { render :partial => "sidebar", :layout => false }
			end
		end
	end

	def create
		@link = Link.new(params[:link])
		
		@link.user = current_user
		
		respond_to do |format|
			format.html {
				if @link.save
					flash[:notice] = 'Link was successfully created.'
					redirect_to admin_link_url(@link)
				else
					@link_search = Link.search(params[:search])
					@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6
					@links = Link.paginate :page => params[:links_page], :per_page => 6
					@page_title << " - Create A New Link"
					
					flash[:alert] = 'Link could not be created.'
					render :action => "new"
				end		
			}
			format.js {
				if @link.save
					session[:return_to] = request.request_uri
					@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6
					@links = Link.paginate :page => params[:links_page], :per_page => 6
					flash.now[:notice] = 'Link was successfully created.'
					render :layout => false
				else
					session[:return_to] = request.request_uri
					@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6
					@links = Link.paginate :page => params[:links_page], :per_page => 6
					flash.now[:alert] = 'Link could not be created.'
					render :layout => false
				end
			}
		end
	end

	def edit
		@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6
		@link = Link.find(params[:id])
		@links = Link.paginate :page => params[:links_page], :per_page => 6
		@page_title << " - Editing - " + @link.title

		respond_to do |format|
			unless request.xhr?
				format.html
			else
				format.js { render :partial => "sidebar", :layout => false }
			end
		end
	end

	def update
		@link = Link.find(params[:id])
		
		@link.user = current_user

		respond_to do |format|
			if @link.update_attributes(params[:link])
				flash[:notice] = 'Link was successfully updated.'
				format.html { redirect_to admin_link_url(@link) }
			else
				@link_search = Link.search(params[:search])
				@link_results = @link_search.all.paginate :page => params[:search_page], :per_page => 6
				@links = Link.paginate :page => params[:links_page], :per_page => 6
				@page_title << " - Editing - " + @link.title
				flash[:alert] = 'Link was not successfully updated.'
				format.html { render :action => "edit" }
			end
		end
	end
  
	def destroy
		@link = Link.find(params[:id])
		@link.destroy
	
		respond_to do |format|
			flash[:notice] = 'Link was successfully deleted.'
			format.html { redirect_to admin_links_url }
		end
	end
	
	def page_title
		@page_title = []
		@page_title << "Links"
	end
	
	def load_search
		@categories = LinkCategory.all
		@link_search = Link.search(params[:search])
	end

end