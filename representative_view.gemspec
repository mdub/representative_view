# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "representative_view/version"

Gem::Specification.new do |gem|
  
  gem.name = "representative_view"
  gem.summary = "Builds XML and JSON from a single view template"
  gem.homepage = "http://github.com/mdub/representative_view"
  gem.authors = ["Mike Williams"]
  gem.email = "mdub@dogbiscuit.org"

  gem.version = RepresentativeView::VERSION.dup
  gem.platform = Gem::Platform::RUBY

  gem.add_runtime_dependency("representative", "~> 0.3.0")
  gem.add_runtime_dependency("actionpack", "~> 3.0.1")
  gem.add_runtime_dependency("nokogiri", ">= 1.4.2")
  gem.add_runtime_dependency("json", ">= 1.4.5")

  gem.require_paths = ["lib"]
  
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- spec/*`.split("\n")

end
