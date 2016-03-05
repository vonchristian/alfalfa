# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'database_cleaner'
require 'capybara/rails'
require 'shoulda/matchers'
ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :webkit
RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
   config.include Rails.application.routes.url_helpers
   config.include RSpec::Rails::RequestExampleGroup, type: :feature
   config.include FactoryGirl::Syntax::Methods

   Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

   config.before(:suite) do
     DatabaseCleaner[:active_record].strategy = :transaction
     DatabaseCleaner.clean_with(:truncation)
   end
   config.before(:each) do
     DatabaseCleaner.start
   end
   config.after(:each) do
     DatabaseCleaner.clean
   end
   Capybara::Webkit.configure do |config|
  # Enable debug mode. Prints a log of everything the driver is doing.
  config.debug = true

  # By default, requests to outside domains (anything besides localhost) will
  # result in a warning. Several methods allow you to change this behavior.

  # Silently return an empty 200 response for any requests to unknown URLs.
  config.block_unknown_urls

  # Allow pages to make requests to any URL without issuing a warning.
  config.allow_unknown_urls

  # Allow a specific domain without issuing a warning.
  config.allow_url("example.com")

  # Allow a specific URL and path without issuing a warning.
  config.allow_url("example.com/some/path")

  # Wildcards are allowed in URL expressions.
  config.allow_url("*.example.com")

  # Silently return an empty 200 response for any requests to the given URL.
  config.block_url("example.com")

  # Timeout if requests take longer than 5 seconds
  config.timeout = 5

  # Don't raise errors when SSL certificates can't be validated
  config.ignore_ssl_errors

  # Don't load images
  config.skip_image_loading

  # Use a proxy
  config.use_proxy(
    host: "example.com",
    port: 1234,
    user: "proxy",
    pass: "secret"
  )
end
end
