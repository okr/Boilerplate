class Admin::PhotosController < ApplicationController
	before_filter :require_admin_user
	skip_after_filter :add_google_analytics_code
	layout 'admin'

	current_tab :photos
	
	def index
		session[:return_to] = request.request_uri

		@photos = @page.photos
		
		@page_title << " - " + @page.title + " Photos"
		
		respond_to do |format|
			unless request.xhr?
				format.html
			else
				if params[:photos_page]
					format.js { render :partial => "photos", :layout => false }
				elsif params[:pages_page]
					format.js { render :partial => "admin/pages/sidebar", :layout => false }
				end
			end
		end
	end

	def higher
		photo = Photo.find(params[:id])
		unless photo.nil?
			if photo.first_item?
				photo.move_to_bottom!
			else
				photo.move_up!
			end
		end

		respond_to do |format|
			flash[:notice] = "Photo position changed successfully."
			format.html { redirect_back_or_default(admin_photos_url) }
		end
	end

	def lower
		photo = Photo.find(params[:id])
		unless photo.nil?
			if photo.last_item?
				photo.move_to_top!
			else
				photo.move_down!
			end
		end

		respond_to do |format|
			flash[:notice] = "Photo position changed successfully."
			format.html { redirect_back_or_default(admin_photos_url) }
		end
	end

	def top
		photo = Photo.find(params[:id])
		unless photo.nil?
			unless photo.first_item?
				photo.move_to_top!
			else
				photo.move_down!
			end
		end

		respond_to do |format|
			flash[:notice] = "Photo position changed successfully."
			format.html { redirect_back_or_default(admin_photos_url) }
		end
	end

	def bottom
		photo = Photo.find(params[:id])
		unless photo.nil?
			unless photo.last_item?
				photo.move_to_bottom!
			else
				photo.move_up!
			end
		end

		respond_to do |format|
			flash[:notice] = "Photo position changed successfully."
			format.html { redirect_back_or_default(admin_photos_url) }
		end
	end

	def crop
		@photo = Photo.find(params[:id])

		respond_to do |format|
			flash[:notice] = "Photo cropped successfully."
			format.html { redirect_back_or_default(admin_photos_url) }
		end
	end

end
