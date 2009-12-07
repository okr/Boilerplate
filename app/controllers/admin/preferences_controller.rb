class Admin::PreferencesController < ApplicationController
    before_filter :require_admin_user, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'

	current_tab :preferences
	
	def index
	    @preference = Preference.first
	    
	    respond_to do |format|
			format.html
			format.js
		end
	end
	
	def show
	    
	end
	
	def edit
	    
	end
	
	def update
	    
	end
	
	def page_title
		@page_title = []
		
		@page_title << "Site Preferences"
	end
end
