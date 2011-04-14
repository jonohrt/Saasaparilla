# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{saasaparilla}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2011-04-14}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "app/controllers/saasaparilla/application_controller.rb",
    "app/controllers/saasaparilla/billing_history_controller.rb",
    "app/controllers/saasaparilla/contact_info_controller.rb",
    "app/controllers/saasaparilla/credit_card_controller.rb",
    "app/controllers/saasaparilla/invoices_controller.rb",
    "app/controllers/saasaparilla/payments_controller.rb",
    "app/controllers/saasaparilla/plans_controller.rb",
    "app/controllers/saasaparilla/subscription_controller.rb",
    "app/helpers/application_helper.rb",
    "app/helpers/plans_helper.rb",
    "app/helpers/saasaparilla/billing_history_helper.rb",
    "app/mailers/saasaparilla/notifier.rb",
    "app/models/billing_activity.rb",
    "app/models/contact_info.rb",
    "app/models/credit_card.rb",
    "app/models/invoice.rb",
    "app/models/invoice_line_item.rb",
    "app/models/payment.rb",
    "app/models/plan.rb",
    "app/models/subscription.rb",
    "app/models/transaction.rb",
    "app/views/layouts/saasaparilla.html.haml",
    "app/views/saasaparilla/billing_history/_billing_activity.html.haml",
    "app/views/saasaparilla/billing_history/show.html.haml",
    "app/views/saasaparilla/contact_info/edit.html.haml",
    "app/views/saasaparilla/credit_card/edit.html.haml",
    "app/views/saasaparilla/invoices/show.html.haml",
    "app/views/saasaparilla/notifier/billing_failed.html.haml",
    "app/views/saasaparilla/notifier/billing_successful.html.haml",
    "app/views/saasaparilla/notifier/invoice_created.html.haml",
    "app/views/saasaparilla/notifier/pending_cancellation_notice.html.haml",
    "app/views/saasaparilla/notifier/subscription_cancelled.html.haml",
    "app/views/saasaparilla/notifier/subscription_created.html.haml",
    "app/views/saasaparilla/payments/edit.html.haml",
    "app/views/saasaparilla/payments/new.html.haml",
    "app/views/saasaparilla/payments/show.html.haml",
    "app/views/saasaparilla/plans/_form.html.haml",
    "app/views/saasaparilla/plans/edit.html.erb",
    "app/views/saasaparilla/plans/index.html.erb",
    "app/views/saasaparilla/plans/new.html.erb",
    "app/views/saasaparilla/plans/show.html.erb",
    "app/views/saasaparilla/subscription/_contact_info_form.html.haml",
    "app/views/saasaparilla/subscription/_credit_card_form.html.haml",
    "app/views/saasaparilla/subscription/new.html.haml",
    "app/views/saasaparilla/subscription/show.html.haml",
    "config/routes.rb",
    "lib/country_select/MIT-LICENSE",
    "lib/country_select/README",
    "lib/country_select/init.rb",
    "lib/country_select/install.rb",
    "lib/country_select/lib/country_select.rb",
    "lib/country_select/uninstall.rb",
    "lib/extensions/active_record/nested_attributes.rb",
    "lib/extensions/active_record/statuses.rb",
    "lib/extensions/billable.rb",
    "lib/generators/saasaparilla/install/install_generator.rb",
    "lib/generators/saasaparilla/install/templates/create_saasaparilla_tables.rb",
    "lib/generators/saasaparilla/install/templates/saasaparilla.yml",
    "lib/initializers/auth_dot_net.rb",
    "lib/initializers/simple_form.rb",
    "lib/initializers/time_format.rb",
    "lib/saasaparilla.rb",
    "lib/saasaparilla/engine.rb"
  ]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Saas engine}
  s.test_files = [
    "spec/dummy/app/controllers/application_controller.rb",
    "spec/dummy/app/helpers/application_helper.rb",
    "spec/dummy/app/model/user.rb",
    "spec/dummy/config/application.rb",
    "spec/dummy/config/boot.rb",
    "spec/dummy/config/environment.rb",
    "spec/dummy/config/environments/development.rb",
    "spec/dummy/config/environments/production.rb",
    "spec/dummy/config/environments/test.rb",
    "spec/dummy/config/initializers/backtrace_silencers.rb",
    "spec/dummy/config/initializers/inflections.rb",
    "spec/dummy/config/initializers/mime_types.rb",
    "spec/dummy/config/initializers/secret_token.rb",
    "spec/dummy/config/initializers/session_store.rb",
    "spec/dummy/config/initializers/simple_form.rb",
    "spec/dummy/config/routes.rb",
    "spec/dummy/db/migrate/20110404214729_create_user.rb",
    "spec/dummy/db/schema.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/init.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/install.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/lib/authorize_net_cim_gateway_test.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/lib/authorize_net_gateway_test.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/lib/paypal_express_gateway_test.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/test/activemerchant_testing_test.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/test/test_helper.rb",
    "spec/dummy/vendor/plugins/active_merchant_testing/uninstall.rb",
    "spec/factories/factories.rb",
    "spec/integration/navigation_spec.rb",
    "spec/mailers/notifier_spec.rb",
    "spec/models/billing_activity_spec.rb",
    "spec/models/contact_info_spec.rb",
    "spec/models/credit_card_spec.rb",
    "spec/models/invoice_line_item_spec.rb",
    "spec/models/invoice_spec.rb",
    "spec/models/payment_spec.rb",
    "spec/models/plan_spec.rb",
    "spec/models/subscription_spec.rb",
    "spec/requests/billing_history_spec.rb",
    "spec/requests/contact_info_controller_spec.rb",
    "spec/requests/credit_cards.rb",
    "spec/requests/invoices_spec.rb",
    "spec/requests/payments_spec.rb",
    "spec/requests/plans_spec.rb",
    "spec/requests/subscriptions_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, ["= 3.0.5"])
      s.add_runtime_dependency(%q<sqlite3>, [">= 0"])
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<jeweler>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<dynamic_attributes>, [">= 0"])
      s.add_runtime_dependency(%q<authlogic>, [">= 0"])
      s.add_runtime_dependency(%q<active_merchant>, [">= 0"])
      s.add_runtime_dependency(%q<simple_form>, [">= 0"])
      s.add_runtime_dependency(%q<dynamic_form>, [">= 0"])
      s.add_runtime_dependency(%q<state_machine>, [">= 0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0"])
      s.add_development_dependency(%q<autotest-growl>, [">= 0"])
      s.add_development_dependency(%q<autotest-fsevent>, [">= 0"])
      s.add_development_dependency(%q<autotest-rails>, [">= 0"])
      s.add_development_dependency(%q<factory_girl_rails>, [">= 1.0.1"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<spork>, [">= 0"])
      s.add_development_dependency(%q<launchy>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<ZenTest>, [">= 0"])
      s.add_development_dependency(%q<email_spec>, [">= 0"])
    else
      s.add_dependency(%q<rails>, ["= 3.0.5"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<dynamic_attributes>, [">= 0"])
      s.add_dependency(%q<authlogic>, [">= 0"])
      s.add_dependency(%q<active_merchant>, [">= 0"])
      s.add_dependency(%q<simple_form>, [">= 0"])
      s.add_dependency(%q<dynamic_form>, [">= 0"])
      s.add_dependency(%q<state_machine>, [">= 0"])
      s.add_dependency(%q<i18n>, [">= 0"])
      s.add_dependency(%q<autotest-growl>, [">= 0"])
      s.add_dependency(%q<autotest-fsevent>, [">= 0"])
      s.add_dependency(%q<autotest-rails>, [">= 0"])
      s.add_dependency(%q<factory_girl_rails>, [">= 1.0.1"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<spork>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<ZenTest>, [">= 0"])
      s.add_dependency(%q<email_spec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, ["= 3.0.5"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<dynamic_attributes>, [">= 0"])
    s.add_dependency(%q<authlogic>, [">= 0"])
    s.add_dependency(%q<active_merchant>, [">= 0"])
    s.add_dependency(%q<simple_form>, [">= 0"])
    s.add_dependency(%q<dynamic_form>, [">= 0"])
    s.add_dependency(%q<state_machine>, [">= 0"])
    s.add_dependency(%q<i18n>, [">= 0"])
    s.add_dependency(%q<autotest-growl>, [">= 0"])
    s.add_dependency(%q<autotest-fsevent>, [">= 0"])
    s.add_dependency(%q<autotest-rails>, [">= 0"])
    s.add_dependency(%q<factory_girl_rails>, [">= 1.0.1"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<spork>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<ZenTest>, [">= 0"])
    s.add_dependency(%q<email_spec>, [">= 0"])
  end
end

