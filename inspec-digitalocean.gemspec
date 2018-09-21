# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'inspec/digitalocean'

Gem::Specification.new do |gem|
  gem.name          = 'inspec-digitalocean'
  gem.version       = Inspec::Digitalocean::VERSION
  gem.license       = 'Apache 2.0'
  gem.authors       = ['Brandon Raabe']
  gem.email         = ['brandocorp@gmail.com']
  gem.description   = 'An Inspec plugin for testing Libvirt infrastructure.'
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/brandocorp/inspec-libvirt'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = []
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'droplet_kit'
  gem.add_dependency 'inspec', '~> 2.2', '>= 2.2.70'

  gem.add_development_dependency 'rspec',     '~> 3.2'
  gem.add_development_dependency 'simplecov', '~> 0.7'
  gem.add_development_dependency 'yard',      '~> 0.9', '>= 0.9.11'
end
