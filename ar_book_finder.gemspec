# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar_book_finder/version'

Gem::Specification.new do |spec|
  spec.name          = "ar_book_finder"
  spec.version       = ARBookFinder::VERSION
  spec.authors       = ["Anthony Smith"]
  spec.email         = ["anthony@sticksnleaves.com"]
  spec.description   = %q{Access book data on ARBookFinder}
  spec.summary       = %q{Crawls and parses data on arbookfind.com and returns book data in an easy to use format}
  spec.homepage      = "https://github.com/anthonator/ar-book-finder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'capybara'
  spec.add_runtime_dependency 'poltergeist'
  spec.add_runtime_dependency 'nokogiri'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
