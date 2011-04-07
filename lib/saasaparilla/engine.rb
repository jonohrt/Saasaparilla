require "saasaparilla"
require "rails"
require "action_controller"


module Saasaparilla
  class Engine < Rails::Engine
    initializer "simple_form_init" do |app|
      require 'initializers/simple_form'
    end
  end
end