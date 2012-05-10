# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dsl_accessor/version"

Gem::Specification.new do |s|
  s.name        = "dsl_accessor"
  s.version     = DslAccessor::VERSION
  s.authors     = ["maiha"]
  s.email       = ["maiha@wota.jp"]
  s.homepage    = "https://github.com/maiha/dsl_accessor"
  s.summary     = %q{This plugin gives hybrid accessor class methods to classes by DSL like definition}
  s.description = %q{This plugin gives hybrid accessor class methods to classes by DSL like definition}

  s.rubyforge_project = "dsl_accessor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "optionize", ">= 0.1.0"
  s.add_dependency "blankslate", ">= 2.1.2"

  s.add_development_dependency "rspec"
end
