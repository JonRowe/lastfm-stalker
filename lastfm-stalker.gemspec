# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lastfm-stalker/version"

Gem::Specification.new do |s|
  s.name        = "lastfm-stalker"
  s.version     = Lastfm::Stalker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jon Rowe"]
  s.email       = ["hello@jonrowe.co.uk"]
  s.homepage    = "http://github.com/jonrowe/lastfm-stalker"
  s.summary     = %q{Track lastfm users currently playing tracks}
  s.description = %q{Track lastfm users currently playing tracks}

  s.rubyforge_project = "lastfm-stalker"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'aruba'
end
