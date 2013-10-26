# Require supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'simplecov'
require 'coveralls'
SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start

require 'ar_book_finder'

RSpec.configure do |config|
  config.before(:each) do
    ARBookFinder.configure do |config|
      config.user_type = :teacher
    end
  end
end
