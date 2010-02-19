class Admin::DashboardController < ApplicationController
	before_filter :require_admin_user
	skip_after_filter :add_google_analytics_code
	
	layout 'admin'
	
	current_tab :dashboard

	def index
		
		@page_title = []
		
		@recently_active_objects = TimelineEvent.all.paginate :page => params[:page], :per_page => 6, :order => 'updated_at'
		
		@page_title << "Dashboard"
		
		@links = Link.admin_links
		
		respond_to do |format|
		    format.html
			format.js
		end
	end
  
end
