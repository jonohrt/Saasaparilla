require "saasaparilla"
require "rails"
require "active_merchant"
require "action_controller"
require 'yaml'

require "dynamic_attributes"
require 'extensions/action_controller/authorization'
module Saasaparilla
  class Engine < Rails::Engine
    
    initializer "simple_form_init" do |app|
      require 'initializers/simple_form'
      require 'initializers/time_format'
      if File.exists?(Rails.root.to_s + "/config/saasaparilla.yml")
        raw_config = File.read(Rails.root.to_s + "/config/saasaparilla.yml")
        Saasaparilla::CONFIG = YAML.load(raw_config)[RAILS_ENV]
      end
      require 'initializers/auth_dot_net'
      ActiveSupport.on_load(:action_controller) do
        extend Authorization::ClassMethods
        include Authorization::InstanceMethods
      end
    end
    

    
  end
  
end