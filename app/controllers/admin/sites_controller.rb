class Admin::SitesController < ApplicationController
    before_filter :require_admin_user, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'

	current_tab :site
	
	def index
	    
	end
	
	def show
	    
	end
	
	def edit
	    
	end
	
	def update
	    
	end
end
