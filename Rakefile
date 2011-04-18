# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rake/rdoctask'

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Saasaparilla'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# begin
#   require "jeweler"
#   Jeweler::Tasks.new do |gem|
#     gem.name = "saasaparilla"
#     gem.summary = "Saas engine"
#     gem.files = Dir["{lib}/**/*", "{app}/**/*", "{config}/**/*"]
#     # other fields that would normally go in your gemspec
#     # like authors, email and has_rdoc can also be included here
# 
#   end
# rescue
#   puts "Jeweler or one of its dependencies is not installed."
# end