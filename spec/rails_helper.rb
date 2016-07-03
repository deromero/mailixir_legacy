ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require "capybara/rspec"
require 'factory_girl_rails'
require 'support/factory_girl'


Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.app_host = 'http://example.com'

RSpec.configure do |config|

  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods

  # Database_cleaner
  config.before(:suite) do
    if config.use_transactional_fixtures?
      raise("Delete line `config.use_transactional_fixtures = true` from rails_helper.rb\n(or set it to false) to prevent uncommitted transactions being used in\nJavaScript-dependent specs.\n\nDuring testing, the app-under-test that the browser driver connects to\nuses a different database connection to the database connection used by\nthe spec. The app's database connection would not be able to access\nuncommitted transaction data setup over the spec's database connection.\n")
    end
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

    if !driver_shares_db_connection_with_specs
      DatabaseCleaner.strategy = :truncation
    end
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
    Apartment::Database.reset
    drop_schemas
    Capybara.app_host = "http://example.com"
  end


  config.include Features, type: :feature

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      # Choose a test framework:
      with.test_framework :rspec
      # with.test_framework :minitest
      # with.test_framework :minitest_4
      # with.test_framework :test_unit

      # Choose one or more libraries:
      with.library :active_record
      with.library :active_model
      with.library :action_controller
      # Or, choose the following (which implies all of the above):
      with.library :rails
    end
  end

end
