source "http://rubygems.org"

gemspec
gem "rails", "3.0.5"

gem "sqlite3"
gem 'haml'
gem 'will_paginate'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
gem RUBY_VERSION.include?('1.9') ? 'ruby-debug19' : 'ruby-debug'

gem "jquery-rails"
gem "dynamic_attributes"
gem "authlogic"
gem 'activemerchant', ">= 1.20.0"
gem 'simple_form'
gem 'dynamic_form'
gem 'state_machine'
gem 'bartt-ssl_requirement', :require => 'ssl_requirement'
gem 'i18n'
group :development, :test do
  gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
	gem "autotest-growl"
	gem "autotest-fsevent"
  gem "autotest-rails"
  gem "factory_girl_rails", ">= 1.0.1"
  gem "rspec-rails"

  gem 'database_cleaner'
  gem 'spork'
  gem 'launchy'
  gem 'shoulda'
  gem 'ZenTest'
  gem 'email_spec'
end
