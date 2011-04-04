# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{saasaparilla}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2011-03-31}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "app/controllers/saasaparilla/application_controller.rb",
    "app/controllers/saasaparilla/test_controller.rb",
    "config/routes.rb",
    "lib/saasaparilla.rb"
  ]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Saas engine}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["= 3.0.1"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.0.0.beta"])
      s.add_development_dependency(%q<capybara>, [">= 0.3.9"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<cucumber-rails>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<spork>, [">= 0"])
      s.add_development_dependency(%q<launchy>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["= 3.0.1"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<factory_girl_rails>, [">= 0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.0.0.beta"])
      s.add_dependency(%q<capybara>, [">= 0.3.9"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<cucumber-rails>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<spork>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["= 3.0.1"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<factory_girl_rails>, [">= 0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.0.0.beta"])
    s.add_dependency(%q<capybara>, [">= 0.3.9"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<cucumber-rails>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<spork>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 0"])
  end
end

