# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'pry'

# Add this to load Capybara integration:
#require 'capybara/rspec'
#require 'capybara-screenshot/rspec'
#require 'capybara/rails'
#require 'factory_girl_rails'

#Capybara.save_and_open_page_path = ENV["CIRCLE_ARTIFACTS"]
#Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i

# require 'capybara/poltergeist'

# Capybara.register_driver :chrome do |app|
#     Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

# Capybara.javascript_driver = :chrome

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
      # ## Mock Framework
      #
      # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
      #
      # config.mock_with :mocha
      # config.mock_with :flexmock
      # config.mock_with :rr

      # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
      # config.fixture_path = "#{::Rails.root}/spec/fixtures"

      # If you're not using ActiveRecord, or you'd prefer not to run each of your
      # examples within a transaction, remove the following line or assign false
      # instead of true.
      # config.use_transactional_fixtures = true

      # If true, the base class of anonymous controllers will be inferred
      # automatically. This will be the default behavior in future versions of
      # rspec-rails.
      config.infer_base_class_for_anonymous_controllers = false

      # Run specs in random order to surface order dependencies. If you find an
      # order dependency and want to debug it, you can fix the order by providing
      # the seed, which is printed after each run.
      #     --seed 1234
      config.order = "default"
end

def basic_auth_login
  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(ApplicationController::DEFAULT_USERNAME, ApplicationController::DEFAULT_PASSWORD)
end

def get_dynosaur_config(num_plugins)
  api_key = SecureRandom.uuid
  app_name = SecureRandom.uuid[0..12]
  config = ScalerConfig.new
  config.min_web_dynos = 3
  config.max_web_dynos = 27
  config.heroku_app_name = app_name
  config.heroku_api_key = api_key
  config.dry_run = true
  config.interval = 5
  config.blackout = 10
  config.librato_api_key = SecureRandom.uuid
  config.librato_email = SecureRandom.uuid
  config.save!

  plugins = []
  num_plugins.times { |i|
    plugin = config.plugin_configs.new
    plugin.name = "random_#{i}"
    plugin.plugin_type = "RandomPlugin"
    plugin.save!
    plugin.set_item("seed", "1234")
    plugins << plugin
  }
  return config
end
