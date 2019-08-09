# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activerecord-mysql-structure/version'

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-mysql-structure'
  spec.version       = ActiveRecord::Mysql::Structure::VERSION
  spec.authors       = ['Steve Rice']
  spec.email         = ['steve@pagerduty.com']
  spec.summary       = 'Cleaner structure.sql for MySQL.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/PagerDuty/activerecord-mysql-structure'
  spec.license       = 'Apache 2'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_runtime_dependency 'activerecord', '>= 3.2', '< 6.0'
end
