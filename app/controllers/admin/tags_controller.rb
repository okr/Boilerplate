class Admin::TagsController < ApplicationController
    before_filter :require_admin_user
	skip_after_filter :add_google_analytics_code
	layout 'admin'
	
    def index
       #ActiveRecord::Base.include_root_in_json = false
        
        @tags = Tag.search(:name_like => params[:q]).all
        
        respond_to do |format|
            format.json { render :text => @tags.to_json(:only => [:id, :name]) } if request.xhr?
            format.html { render :text => @tags.to_json(:only => [:id, :name]) }
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
