class ContactController < ApplicationController
	before_filter :page_title
	layout 'application'
	
	def new
		session[:return_to] = request.request_uri
		@categories = Category.roots
		@contact_form = ContactForm.new

		respond_to do |format|
			format.html
			format.js
		end
	end
	
	def create
		@contact_form = ContactForm.new(params[:contact_form], request)
		
		respond_to do |format|
			if @contact_form.save       
				flash[:notice] = 'Thank you for emailing us.'
				@contact_form.deliver
				format.html { redirect_to contact_url }
			else
				@categories = Category.roots
				flash[:alert] = 'Something went wrong, your email could not be delivered at this time.'
				format.html { render :action => "new" }
			end
		end
	end
	
	def page_title
		@page_title = "Contact Us"
	end
end