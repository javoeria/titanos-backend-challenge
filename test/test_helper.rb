ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "simplecov"
require "rails/test_help"
SimpleCov.start

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def before_setup
      Bullet.start_request
      super
    end

    def after_teardown
      super
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
  end
end
