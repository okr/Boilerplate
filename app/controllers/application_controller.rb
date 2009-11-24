class ApplicationController < ActionController::Base  
	layout "application"
	helper :all
	before_filter :correct_safari_and_ie_accept_headers, :current_user, :dev_authenticate
	filter_parameter_logging :password, :password_confirmation, :old_password
	skip_after_filter :add_google_analytics_code

	protect_from_forgery

	def load_public_pages
		@pages = Page.published.all(:conditions => {:home => false})
	end
	
	def correct_safari_and_ie_accept_headers
		request.accepts.sort!{ |x, y| y.to_s == 'application/xml' ? 1 : -1 } if request.xhr?
	end

	protected

	private

	def development?
		ENV['RAILS_ENV'] == 'development'
	end

	def dev_authenticate
		if development?
			authenticate_or_request_with_http_basic do |username, password|
				username == "admin" && password == "t3st"
			end
		end
	end

	def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.record
	end

	def require_admin_user
		unless @current_user and @current_user.role.name == "admin"
			store_location
			flash[:error] = "You must be logged in as an admin to access this page."
			redirect_to login_path
			return false
		end
	end

	def require_no_admin_user
		if @current_user and @current_user.role.name == "admin"
			store_location
			flash[:error] = "You must be logged out to access this page."
			redirect_to login_path
			return false
		end
	end

	def require_default_user
		unless @current_user and @current_user.role.name == "default"
			store_location
			flash[:error] = "You must be logged in to access this page."
			redirect_to login_path
			return false
		end
	end

	def require_no_default_user
		if @current_user and @current_user.role.name == "default"
			store_location
			flash[:error] = "You must be logged out to access this page."
			redirect_to login_path
			return false
		end
	end

	def require_no_user
		if @current_user
			store_location
			flash[:error] = "You must be logged out to access this page."
			redirect_to admin_root_path
			return false
		end
	end

	def store_location
		session[:return_to] = request.request_uri
	end

	def redirect_back_or_default(default)
		redirect_to(session[:return_to] || default)
		session[:return_to] = nil
	end

end