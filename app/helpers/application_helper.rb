# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
	def nice_month(date)
		date = "#{h date.strftime('%b')}"
	end

	def nice_day(date)
		date = "#{h date.strftime('%d')}"
	end
	
	def generate_html(form_builder, method, options = {})
		options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
		options[:partial] ||= method.to_s.singularize
		options[:form_builder_local] ||= :f

		form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
			locals = { options[:form_builder_local] => f }
			render(:partial => options[:partial], :locals => locals)
		end
	end

	def generate_template(form_builder, method, options = {})
		escape_javascript generate_html(form_builder, method, options)
	end
	
	def logged_in_users
	    User.logged_in.count
	end
	
end
