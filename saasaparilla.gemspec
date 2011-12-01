# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "saasaparilla/version"

Gem::Specification.new do |s|
  s.name        = "saasaparilla"
  s.version     = Saasaparilla::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jon Ohrt", "Matt Fordham"]
  s.email       = ["jonohrt1@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Simple SAAS through Authorize.net}
  s.description = %q{Simple SAAS through Authorize.net}

  s.rubyforge_project = "saasaparilla"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency(%q<bartt-ssl_requirement>, [">=0"])
  s.add_runtime_dependency(%q<will_paginate>, [">=0"])
  s.add_runtime_dependency(%q<haml>, [">= 0"])
  s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
  s.add_runtime_dependency(%q<dynamic_attributes>, [">= 0"])
  s.add_runtime_dependency(%q<authlogic>, [">= 0"])
  s.add_runtime_dependency(%q<activemerchant>, [">= 0"])
  s.add_runtime_dependency(%q<simple_form>, [">= 0"])
  s.add_runtime_dependency(%q<dynamic_form>, [">= 0"])
  s.add_runtime_dependency(%q<i18n>, [">= 0"])
  s.add_runtime_dependency(%q<activemerchant>, [">= 1.20.0"])

  s.add_development_dependency(%q<autotest-growl>, [">= 0"])
  s.add_development_dependency(%q<autotest-fsevent>, [">= 0"])
  s.add_development_dependency(%q<autotest-rails>, [">= 0"])
  s.add_development_dependency(%q<factory_girl_rails>, [">= 1.0.1"])
  s.add_development_dependency(%q<rspec-rails>, [">= 0"])

  s.add_development_dependency(%q<database_cleaner>, [">= 0"])
  s.add_development_dependency(%q<spork>, [">= 0"])
  s.add_development_dependency(%q<launchy>, [">= 0"])
  s.add_development_dependency(%q<shoulda>, [">= 0"])
  s.add_development_dependency(%q<ZenTest>, [">= 0"])
  s.add_development_dependency(%q<email_spec>, [">= 0"])
end



