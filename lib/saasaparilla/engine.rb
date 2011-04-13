require "saasaparilla"
require "rails"
require "action_controller"
require 'yaml'

module Saasaparilla
  class Engine < Rails::Engine
    
    initializer "simple_form_init" do |app|
      require 'initializers/simple_form'
      require 'initializers/time_format'
      raw_config = File.read(RAILS_ROOT + "/config/saasaparilla.yml")
      Saasaparilla::CONFIG = YAML.load(raw_config)[RAILS_ENV]

    end
  end
  
end