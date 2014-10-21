require "simplecov"
require "codeclimate-test-reporter"
require "pry"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  CodeClimate::TestReporter::Formatter
]
SimpleCov.start

require "nem"

RSpec.configure do |config|
  config.order = "random"
end

def fixture(filename)
  path = "#{File.dirname(__FILE__)}/fixtures/#{filename}"
  File.open(path)
end
