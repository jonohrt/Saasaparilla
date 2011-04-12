# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
#require "rails/test_help"
require "rspec/rails"

require 'shoulda'
require 'factory_girl_rails'
require 'email_spec'

Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each {|f| require f}

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

Rails.backtrace_cleaner.remove_silencers!

# Configure capybara for integration testing
require "capybara/rails"
require "spork"
Spork.prefork do
     require 'capybara/rspec'
end
Capybara.default_driver   = :rack_test
Capybara.default_selector = :css

require 'database_cleaner'
# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

include Rails.application.routes.url_helpers

     
RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  #config.include RSpec::Matchers

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
  
  # == Mock Framework
  config.mock_with :rspec
  
  config.use_transactional_fixtures = false
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end


