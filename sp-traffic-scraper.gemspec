# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sp-traffic-scraper/version"

Gem::Specification.new do |s|
  s.name        = "sp-traffic-scraper"
  s.version     = Sp::Traffic::Scraper::VERSION
  s.authors     = ["Rodrigo Flores"]
  s.email       = ["mail@rodrigoflores.org"]
  s.homepage    = ""
  s.summary     = %q{A gem to retrieve data from CET SP website}
  s.description = %q{This gem parses the traffic engineering company and retrieves traffic information for the city of Sao Paulo Brazil}

  s.rubyforge_project = "sp-traffic-scraper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "nokogiri"

  s.add_development_dependency "rspec"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "yard"
end
