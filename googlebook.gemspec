# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'googlebook/version'

Gem::Specification.new do |s|
  s.name        = 'googlebook'
  s.version     = GoogleBook::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Paper Cavalier']
  s.email       = ['code@papercavalier.com']
  s.homepage    = 'http://rubygems.com/gems/googlebook'
  s.summary     = %q{A Ruby wrapper to the Google Book Search Data API}
  s.description = %q{Google Book is a Ruby wrapper to the Google Book Search Data API.}

  s.rubyforge_project = 'googlebook'

  s.add_dependency('httparty', ['~> 0.7.4'])
  s.add_development_dependency('rspec', ['~> 2.5.0'])
  s.add_development_dependency('vcr', '~> 1.7.0')
  s.add_development_dependency('webmock', '~> 1.6.2')

  s.files         = `git ls-files`.split('\n')
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables   = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
