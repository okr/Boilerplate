class UserSessionsController < ApplicationController
	before_filter :require_no_user, :only => :create
	before_filter :require_admin_user, :only => :destroy
	layout 'admin'
    
	def new
		@user_session = UserSession.new
	end

	def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.save
			flash[:notice] = "Login successful!"
			redirect_back_or_default(admin_root_url)
		else
			flash[:error] = "Your user name or password is incorrect."
			redirect_to login_url
		end
	end

	def destroy
		current_user_session.destroy
		flash[:notice] = "Logout successful!"
		redirect_to login_url
	end
end