class Admin::TagsController < ApplicationController
    before_filter :require_admin_user
	skip_after_filter :add_google_analytics_code
	layout 'admin'
	
    def index
        @tags = Tag.all
        
        respond_to do |format|
            format.js
        end 
	end
	
	def show
	    
	end
	
	def new
	    
	end
	
	def create
	    
	end
	
	def edit
	    
	end
	
	def update
	    
	end
	
	def delete
	    
	end
end
