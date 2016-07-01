# frozen_string_literal: true
Gem::Specification.new do |s|
  s.name          = 'lita-votma'
  s.version       = '0.1.0'
  s.authors       = ['janost']
  s.description   = 'Votma plugin for lita'
  s.summary       = 'Votma plugin for lita'
  s.metadata      = { 'lita_plugin_type' => 'handler' }

  s.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'lita', '>= 4.7'
  s.add_runtime_dependency 'activerecord', '~> 5.0'
  s.add_runtime_dependency 'activesupport', '~> 5.0'
  s.add_runtime_dependency 'addressable', '~> 2.4'
  s.add_runtime_dependency 'sqlite3', '~> 1.3.11'

  s.add_development_dependency 'bundler', '~> 1.12'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'rspec', '>= 3.4'
  s.add_development_dependency 'rubocop', '~> 0.41'
end
