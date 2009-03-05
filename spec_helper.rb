# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
# Load the environment
ENV['RAILS_ENV'] ||= 'sqlite3'
require File.expand_path(File.dirname(__FILE__) + '/rails_root/config/environment.rb')

require 'spec'
require 'spec/rails'

# Load the testing framework
require 'test/unit'
require 'active_record/fixtures'
# Run the migrations
migration_directory = File.join(File.dirname(__FILE__), "..", "db", "migrate")
ActiveRecord::Migrator.migrate(migration_directory,1)
ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate",2)

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = false #true
  config.use_instantiated_fixtures  = false
  config.fixture_path = File.dirname(__FILE__) + '/fixtures/'
  
  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Example::Configuration and Spec::Runner
  
end
