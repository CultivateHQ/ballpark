# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :flexmock


end

module ControllerHelper
  def self.included(mod)
    mod.class_eval do 
      render_views

      def self.always_creates_event

        before(:each) do
          @event = Event.create(:name=>'Och AYE')
        end

        after(:each) do
          Event.all.each {|e| e.destroy}
        end
      end

      def self.always_login
        before(:each) do
          login
        end
      end
    end
  end



  def login
    request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("ruby:w3r3w01f")
  end
end
