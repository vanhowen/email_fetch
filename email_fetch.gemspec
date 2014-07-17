# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_fetch/version'

Gem::Specification.new do |spec|
  spec.name          = 'email_fetch'
  spec.version       = EmailFetch::VERSION
  spec.authors       = ['Nicholas VanHowe']
  spec.email         = ['vanhowen@gmail.com']
  spec.summary       = %q{A Ruby library for collecting email addresses from the web.}
  spec.description   = %q{A Ruby library for collecting email addresses from the web.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'rb-fsevent'


  spec.add_dependency 'fuzzy_match'
  spec.add_dependency 'glutton_ratelimit'
  spec.add_dependency 'log4r'
  spec.add_dependency 'mechanize'
end
