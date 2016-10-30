require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'

require 'rspec'
require 'factory_girl'
require 'rack/test'
require_relative '../app/todo_api'
require_relative '../app/models/todo'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.before(:all) do
    FactoryGirl.reload
  end
  config.before :each do
    Todo.destroy_all
  end
end
