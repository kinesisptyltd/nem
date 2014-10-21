# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nem/version"

Gem::Specification.new do |s|
  s.name          = "nem"
  s.version       = NEM::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = %q{NEM12 and NEM13 CSV parser}
  s.description   = %q{NEM12 and NEM13 CSV parser}
  s.authors       = %w(Christopher Chow)
  s.email         = %w(christopher.chow@kinesis.org)
  s.homepage      = "https://github.com/kinesisptyltd/nem"
  s.license       = "MIT"
  s.files         = Dir["lib/**/*", "spec/**/*", "bin/*"]
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 1.9.3"

  s.add_dependency "activesupport"

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "awesome_print"
  s.add_development_dependency "pry"
  s.add_development_dependency "pry-nav"
  s.add_development_dependency "yard"
  s.add_development_dependency "guard-yard"
  s.add_development_dependency "codeclimate-test-reporter"
end
