# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "googlebook/version"

Gem::Specification.new do |s|
  s.name        = "googlebook"
  s.version     = GoogleBook::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Hakan Ensari"]
  s.email       = ["hakan.ensari@papercavalier.com"]
  s.homepage    = "http://github.com/papercavalier/googlebook"
  s.summary     = %q{A Ruby class in tight embrace with the Google Book Search Data API}
  s.description = %q{Google Book is a Ruby class in tight embrace with the Google Book Search Data API.}

  s.rubyforge_project = "googlebook"

  s.add_dependency("httparty", ["~> 0.6.1"])
  s.add_development_dependency("rdiscount", "~> 1.6.5")
  s.add_development_dependency("rspec", ["~> 2.0.1"])
  s.add_development_dependency("sdoc-helpers", "~> 0.1.4")
  s.add_development_dependency("vcr", "~> 1.2.0")
  s.add_development_dependency("webmock", "~> 1.4.0")

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
