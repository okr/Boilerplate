class Admin::EventsController < ApplicationController
	before_filter :require_admin_user, :load_search, :page_title
	skip_after_filter :add_google_analytics_code
	layout 'admin'

	current_tab :calendar

	def index
		session[:return_to] = request.request_uri
		@event_results = @event_search.all.paginate :page => params[:search_page], :per_page => 12
		@event = Event.new

		respond_to do |format|
			format.html
			format.js { render :partial => "search_results", :layout => false }
		end
	end

	def show
		session[:return_to] = request.request_uri
		@event_results = @event_search.all.paginate :page => params[:search_page], :per_page => 12
		@event = Event.find(params[:id])
		@events = Event.paginate :page => params[:events_page], :per_page => 6
		@page_title << " - " + @event.title

		respond_to do |format|
			format.html
			format.js
			format.xml	{ render :xml => @event.to_xml }
		end
	end

	def new
		session[:return_to] = request.request_uri
		@event_results = @event_search.all.paginate :page => params[:search_page], :per_page => 12
		@event = Event.new
		@events = Event.paginate :page => params[:events_page], :per_page => 6
		@page_title << " - Create A New Event"

		respond_to do |format|
			format.html
			format.js
		end
	end

	def create
		@event = Event.new(params[:event])
		
		@event.user = current_user

		respond_to do |format|
			if @event.save		
				flash[:notice] = 'Event was successfully created.'
				format.html { redirect_to admin_event_url(@event) }
				format.js { render :partial => "event_results", :layout => false }
			else
				@event_search = Event.search(params[:search])
				@event_results = @event_search.all.paginate :page => params[:search_page], :per_page => 12
				@events = Event.paginate :page => params[:events_page], :per_page => 6
				@page_title << " - Create A New Event"

				flash[:alert] = 'Event could not be created.'
				format.html { render :action => "new" }
				format.js
			end
		end
	end

	def edit
		session[:return_to] = request.request_uri
		@event_results = @event_search.all.paginate :page => params[:search_page], :per_page => 12
		@event = Event.find(params[:id])
		@events = Event.paginate :page => params[:events_page], :per_page => 6
		@page_title << " - Editing - " + @event.title

		respond_to do |format|
			format.html
			format.js
		end
	end

	def update
		@event = Event.find(params[:id])
		
		@event.user = current_user

		respond_to do |format|
			if @event.update_attributes(params[:event])
				flash[:notice] = 'Event was successfully updated.'
				format.html { redirect_to admin_event_url(@event) }
			else
				@event_search = Event.search(params[:search])
				@event_results = @event_search.all.paginate :page => params[:search_page], :per_page => 12
				@events = Event.paginate :page => params[:events_page], :per_page => 6
				@page_title << " - Editing - " + @event.title
				flash[:alert] = 'Event was not successfully updated.'
				format.html { render :action => "edit" }
			end
		end
	end

	def destroy
		@event = Event.find(params[:id])
		@event.destroy

		respond_to do |format|
			flash[:notice] = 'Event was successfully deleted.'
			format.html { redirect_to admin_events_url }
		end
	end

	def page_title
		@page_title = []

		@page_title << "Events"
	end

	def load_search
		@categories = EventCategory.all
		@event_search = Event.search(params[:search])
	end
	
end
