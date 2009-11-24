class Admin::PagesController < ApplicationController
	before_filter :require_admin_user, :load_search, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'

	current_tab :pages
   
	def show
		session[:return_to] = request.request_uri
		@pages = Page.paginate :page => params[:pages_page], :per_page => 6, :order => :position
		@page = Page.find(params[:id])
		
		@page_title << " - " + @page.title

		respond_to do |format|
			unless request.xhr?
				format.html
			else
				format.js { render :partial => "sidebar", :layout => false }
			end
		end
	end

	def index
		session[:return_to] = request.request_uri
		@page_results = @page_search.all.paginate :page => params[:pages_page], :per_page => 6, :order => :position
		@pages = Page.paginate :page => params[:pages_page], :per_page => 6, :order => :position
		
		respond_to do |format|
			unless request.xhr?
				format.html
			else
				format.js { render :partial => "search_results", :layout => false }
			end
		end
	end

	def new
		session[:return_to] = request.request_uri
		@page_results = @page_search.all.paginate :page => params[:pages_page], :per_page => 6, :order => :position
		@pages = Page.paginate :page => params[:pages_page], :per_page => 6, :order => :position
		@page = Page.new
		
		@page_title << " - Create A New Page"

		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@page = Page.new(params[:page])
		
		if params[:page][:home] == "1"
			for page in Page.homepage.all
				if page.home == true
					page.update_attributes(:home => "false")
				end
			end
			@page.update_attributes(:home => params[:home])
		end
		
		@page.user = current_user

		respond_to do |format|
			if @page.save       
				flash[:notice] = 'Page was successfully created.'
				format.html { redirect_to admin_page_url(@page) }
			else
				@page_search = Page.search(params[:search])
				@page_search.order_by = :position
				@page_results = @page_search.all.paginate :page => params[:pages_page], :per_page => 6, :order => :position
				@pages = Page.paginate :page => params[:pages_page], :per_page => 6, :order => :position
				@page_title << " - Create A New Link"
				flash[:alert] = 'Page could not be created.'
				format.html { render :action => "new" }
			end
		end
	end
	
	def edit
		session[:return_to] = request.request_uri
		@page_results = @page_search.all.paginate :page => params[:pages_page], :per_page => 6, :order => :position
		@page = Page.find(params[:id])
		@pages = Page.paginate :page => params[:pages_page], :per_page => 6, :order => :position
		@page_title << " - Editing - " + @page.title

		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		@page = Page.find(params[:id])
		
		if params[:page][:home] == "1"
			for page in Page.homepage.all
				if page.home == true
					page.update_attributes(:home => "false")
				end
			end
			@page.update_attributes(:home => params[:home])
		end
		
		@page.user = current_user

		respond_to do |format|
			if @page.update_attributes(params[:page])
				flash[:notice] = 'Page was successfully updated.'
				format.html { redirect_to admin_page_url(@page) }
				format.js
			else
				@page_search = Page.search(params[:search])
				@page_search.order_by = :position
				@page_results = @page_search.all.paginate :page => params[:pages_page], :per_page => 6, :order => :position
				@pages = Page.paginate :page => params[:pages_page], :per_page => 6, :order => :position
				@page_title << " - Editing - " + @page.title
				flash[:alert] = 'Page was not successfully updated.'
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@page = Page.find(params[:id])
		@page.destroy

		respond_to do |format|
			flash[:notice] = 'Page was successfully deleted.'
			format.html { redirect_to admin_pages_url }
		end
	end

	def higher
		page = Page.find(params[:id])
		unless page.nil?
			if page.first_item?
				page.move_to_bottom!
			else
				page.move_up!
			end
		end
		
		respond_to do |format|
			format.html {
				flash[:notice] = "Page position changed successfully." 
				redirect_to (session[:return_to] || admin_pages_url)
				session[:return_to] = nil
			}
			format.js {
				flash.now[:notice] = "Page position changed successfully."
				render :layout => false
			}
		end
	end

	def lower
		page = Page.find(params[:id])
		unless page.nil?
			if page.last_item?
				page.move_to_top!
			else
				page.move_down!
			end
		end	
		
		respond_to do |format|
			format.html {
				flash[:notice] = "Page position changed successfully." 
				redirect_to (session[:return_to] || admin_pages_url)
				session[:return_to] = nil
			}
			format.js {
				flash.now[:notice] = "Page position changed successfully."
				render :layout => false
			}
		end
	end

	def top
		page = Page.find(params[:id])
		unless page.nil?
			unless page.first_item?
				page.move_to_top!
			else
				page.move_down!
			end
		end
		
		respond_to do |format|
			format.html {
				flash[:notice] = "Page position changed successfully." 
				redirect_to (session[:return_to] || admin_pages_url)
				session[:return_to] = nil
			}
			format.js {
				flash.now[:notice] = "Page position changed successfully."
				render :layout => false
			}
		end
	end

	def bottom
		page = Page.find(params[:id])
		unless page.nil?
			unless page.last_item?
				page.move_to_bottom!
			else
				page.move_up!
			end
		end
		
		respond_to do |format|
			format.html {
				flash[:notice] = "Page position changed successfully." 
				redirect_to (session[:return_to] || admin_pages_url)
				session[:return_to] = nil
			}
			format.js {
				flash.now[:notice] = "Page position changed successfully."
				render :layout => false
			}
		end
	end
	
	def page_title
		@page_title = []
		
		@page_title << "Pages"
	end
	
	def load_search
		@categories = PageCategory.all
		@page_search = Page.search(params[:search])
	end
end
