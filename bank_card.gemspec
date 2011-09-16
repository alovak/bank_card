# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "bank_card/version"

Gem::Specification.new do |s|
  s.name        = "bank_card"
  s.version     = BankCard::VERSION
  s.authors     = ["Pavel Gabriel"]
  s.email       = ["alovak@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Bunch of methods to work with credit cards}
  s.description = %q{Gem includes validations, card brand detection method, etc.}

  s.rubyforge_project = "bank_card"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
  s.add_development_dependency "ruby-debug19"
  
  s.add_runtime_dependency "activemodel"
  s.add_runtime_dependency "activesupport"
end
