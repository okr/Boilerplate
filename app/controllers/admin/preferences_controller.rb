class Admin::PreferencesController < ApplicationController
    before_filter :require_admin_user, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'

	current_tab :preferences
	
	def index
	    session[:return_to] = request.request_uri
	    @preference = Preference.first
	    
	    respond_to do |format|
			format.html
			format.js
		end
	end
	
	def show
	    
	end
	
	def edit
	    session[:return_to] = request.request_uri
		@preference = Preference.find(params[:id])

		respond_to do |format|
			format.html
			format.js
		end
	end
	
	def update
	    @preference = Preference.find(params[:id])
		
		@preference.user = current_user

		respond_to do |format|
			if @preference.update_attributes(params[:preference])
				flash[:notice] = 'Site preferences were successfully updated.'
				format.html { redirect_to admin_preferences_url }
				format.js { render :layout => false }
			else
				@page_title << "Site Preferences"
				flash[:alert] = 'Site preferences were not successfully updated.'
				format.html { render :action => "edit" }
				format.js { render :layout => false}
			end
		end
	end
	
	def page_title
		@page_title = []
		
		@page_title << "Site Preferences"
	end
end
