class Admin::UsersController < ApplicationController
	before_filter :require_admin_user, :except => [:forgot_password, :request_password_reset, :edit_password, :update_password]
	before_filter :require_no_user, :only => [:forgot_password, :request_password_reset, :edit_password, :update_password]
	before_filter :load_user_using_perishable_token, :only => [:edit_password, :update_password]
	before_filter :page_title, :load_search
	skip_after_filter :add_google_analytics_code
	layout 'admin'
	
	current_tab :users

	def index
		@user_results = @user_search.all.paginate :page => params[:search_page], :per_page => 6
		
		respond_to do |format|
			format.html
			format.js { render :partial => "search_results", :layout => false }
		end
	end

	def new
		@user = User.new
		@users = User.paginate :page => params[:users_page], :per_page => 6
		@user_results = @user_search.all.paginate :page => params[:search_page], :per_page => 6
		 @user.photo.build
		@roles = Role.find(:all)
		
		@page_title << "Create A New User"
		
		respond_to do |format|
			format.html
			format.xml  { head :ok }
		end
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:notice] = "Account created!"
			redirect_back_or_default admin_user_url(@user)
		else
			@users = User.paginate :page => params[:users_page], :per_page => 6
			@user_search = User.search(params[:search])
			@user_results = @user_search.all.paginate :page => params[:search_page], :per_page => 6
			@page_title << "Create A New User"
			@roles = Role.find(:all)
			render :action => 'new'
		end
	end

	def show
    	@user = User.find(params[:id], :include => [:role, :photo])
    	@users = User.paginate :page => params[:users_page], :per_page => 6
    	@user_results = @user_search.all.paginate :page => params[:search_page], :per_page => 6
    
    	@page_title << " - " + @user.name
    
        respond_to do |format|
          format.html
          format.xml  { head :ok }
        end
    end

  def edit
    @user = User.find(params[:id], :include => [:role, :photo])
	@users = User.paginate :page => params[:users_page], :per_page => 6
	@user_results = @user_search.all.paginate :page => params[:search_page], :per_page => 6
    @roles = Role.find(:all)
    @user.build_photo if @user.photo.blank?
	@page_title << " - Editing - " + @user.name
    
    respond_to do |format|
      format.html
    end
  end

  def update
    @user = User.find(params[:id], :include => :role)
    
    if @user.update_attributes(params[:user])
      flash[:notice] = "User account updated!"
      respond_to do |format|
        format.html { redirect_to admin_user_url(@user) }
        #format.js
      end
    else
        flash[:notice] = "User account could not be updated."
	    @users = User.paginate :page => params[:users_page], :per_page => 6
	    @user_search = User.search(params[:search])
	    @user_results = @user_search.all.paginate :page => params[:search_page], :per_page => 6
	    @page_title << " - Editing - " + @user.name
        @roles = Role.find(:all)
        respond_to do |format|
            format.html { render :action => :edit }
            format.js
        end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
	@users = User.paginate :page => params[:users_page], :per_page => 6

    respond_to do |format|
		unless @user == @current_user
			@user.destroy
			flash[:notice] = 'User has been successfully deleted.'
		    format.html { redirect_to admin_users_url }
		else
			flash[:alert] = 'You cannot delete your own account.'
		    format.html { redirect_to admin_user_url(@user) }
		end
    end
  end

	def page_title
		@page_title = []		
		@page_title << "Users"
	end
	
	def load_search
		@user_search = User.search(params[:search])
	end

	def request_password_reset
	  @user = User.find_by_email(params[:email])
	  if @user
	    @user.deliver_password_reset_instructions!
	    flash[:notice] = "Instructions to reset your password have been emailed to you. " + "Please check your email."
	    redirect_to login_url
	  else
	    flash[:notice] = "No user was found with that email address"
	    render :action => :forgot_password
	  end
	end

	def update_password
	  @user.password = params[:user][:password]
	  @user.confirm_password = params[:user][:password_confirmation]
	  if @user.save
	    flash[:notice] = "Password successfully updated"
	    redirect_to admin_user_url(@user)
	  else
	    render :action => :edit_password
	  end
	end
	
	def crop
	    @user = User.find(params[:id], :include => :photo)

        respond_to do |format|
            format.js { render :layout => false }
        end
	end
	
	def update_photo
	    @user = User.find(params[:id], :include => :photo)

        if @user.update_attributes(params[:user])
          flash.now[:notice] = "User photo cropped successfully!"
          respond_to do |format|
              format.js { render :action => "crop", :layout => false }
          end
        else
            flash.now[:error] = "User photo could not be cropped."
            respond_to do |format|
                format.js { render :action => "crop", :layout => false }
            end
        end
	end

private

	def load_user_using_perishable_token  
		@user = User.find_using_perishable_token(params[:id])  
		unless @user  
			flash[:notice] = "We're sorry, but we could not locate your account. " +  
			"If you are having issues try copying and pasting the URL " +  
			"from your email into your browser or restarting the " +  
			"reset password process."  
			redirect_to login_url  
		end
	end

end
