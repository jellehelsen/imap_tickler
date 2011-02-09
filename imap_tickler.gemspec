# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "imap_tickler/version"

Gem::Specification.new do |s|
  s.name        = "imap_tickler"
  s.version     = ImapTickler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jelle Helsen"]
  s.email       = ["jelle.helsen@hcode.be"]
  s.homepage    = "http://rubygems.org/gems/imap_tickler"
  s.summary     = %q{an imap tickler}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "imap_tickler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "delorean"
  s.add_development_dependency "mocha"
end
