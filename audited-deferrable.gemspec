# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "audited/deferrable/version"

Gem::Specification.new do |s|
  s.name        = "audited-deferrable"
  s.version     = Audited::Deferrable::VERSION
  s.author      = "Ben Hughes"
  s.email       = "ben@railsgarden.com"
  s.homepage    = "http://github.com/rubiety/audited-deferrable"
  s.summary     = "Extension to the audited gem to deferred writing of audits via Resque, Delayed Job, or Sidekiq"
  s.description = s.summary
  s.license     = "MIT"

  s.files        = Dir["{lib,spec,vendor}/**/*", "[A-Z]*", "init.rb"]
  s.require_path = "lib"

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"

  s.add_dependency("rails", [">= 3.1.0"])
  s.add_dependency("audited", [">= 3.0.0"])
  s.add_development_dependency("rspec", ["~> 2.13"])
  s.add_development_dependency("appraisal", ["~> 0.5.1"])
  s.add_development_dependency("sqlite3-ruby", ["~> 1.3.1"])
end
