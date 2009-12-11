# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
ENV['RAILS_ENV'] ||= 'development'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

#Load application and environment specific constants
#raw_config = File.read(RAILS_ROOT + "/config/config.yml")
#APP_CONFIG = YAML.load(raw_config)[RAILS_ENV]

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.
  
  config.action_view.sanitized_allowed_tags = 'p', 'a', 'strong', 'em'
  config.action_view.sanitized_bad_tags = 'span', 'div', 'embed', 'object', 'script', 'ul', 'ol', 'li', '&nbsp;', 'i', 'b'
  config.action_view.sanitized_allowed_attributes = 'style'

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "aws-s3", :lib => "aws/s3"

  	config.gem 'authlogic'
	config.gem 'searchlogic'
	config.gem 'settingslogic'
	config.gem 'haml'
	config.gem 'paperclip', :source => 'http://gemcutter.org'
	config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'
	config.gem 'googlebase', :lib => 'google/base'
	config.gem 'rugalytics'
	config.gem 'josevalim-simple_form', :lib => 'simple_form', :source => "http://gems.github.com"
	config.gem 'justinfrench-formtastic', :lib => 'formtastic', :source  => 'http://gems.github.com'
	config.gem 'pauldix-feedzirra', :lib => 'feedzirra', :source  => 'http://gems.github.com'
	config.gem 'shuber-sortable', :lib => 'sortable', :source => 'http://gems.github.com'
	config.gem 'thoughtbot-shoulda', :lib => 'shoulda', :source => 'http://gems.github.com'
	config.gem 'giraffesoft-resource_controller', :lib => 'resource_controller', :source => 'http://gems.github.com'
	config.gem 'giraffesoft-is_taggable', :lib => 'is_taggable', :source => 'http://gems.github.com'
	config.gem 'giraffesoft-timeline_fu', :lib => 'timeline_fu', :source => 'http://gems.github.com'
	config.gem 'friendly_id', :lib => 'friendly_id'
	config.gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"
	config.gem 'jammit', :source => 'http://gemcutter.org'

  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  
  %w(observers sweepers mailers).each do |dir|
    config.load_paths << "#{RAILS_ROOT}/app/#{dir}"
  end

  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_boilerplate_session',
    :secret      => 'b02c410f0ff96e583512e1c50d9a42e0b0906057ab0e29cf91769fd37cb492be885682af2f35031cb152ba3f20c786b5ad42e54ad710b83704c68e226d44faf6'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

end