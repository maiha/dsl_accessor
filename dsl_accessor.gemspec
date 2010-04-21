# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dsl_accessor}
  s.version = "0.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["maiha"]
  s.date = %q{2010-04-22}
  s.description = %q{This plugin gives hybrid accessor class methods to classes by DSL like definition}
  s.email = %q{maiha@wota.jp}
  s.extra_rdoc_files = ["README", "MIT-LICENSE"]
  s.files = ["MIT-LICENSE", "README", "Rakefile", "lib/dsl_accessor.rb", "lib/dsl_accessor", "lib/dsl_accessor/stores.rb", "lib/dsl_accessor/accessor.rb", "lib/dsl_accessor/auto_declare.rb", "spec/module_spec.rb", "spec/writer_spec.rb", "spec/default_spec.rb", "spec/inherit_spec.rb", "spec/accessor_spec.rb", "spec/instance_spec.rb", "spec/auto_declared_spec.rb", "spec/spec_helper.rb", "core_ext/module", "core_ext/module/delegation.rb"]
  s.homepage = %q{http://github.com/maiha/dsl_accessor}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{asakusarb}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{This plugin gives hybrid accessor class methods to classes by DSL like definition}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<optionize>, [">= 0.1.0"])
      s.add_runtime_dependency(%q<blankslate>, [">= 2.1.2"])
    else
      s.add_dependency(%q<optionize>, [">= 0.1.0"])
      s.add_dependency(%q<blankslate>, [">= 2.1.2"])
    end
  else
    s.add_dependency(%q<optionize>, [">= 0.1.0"])
    s.add_dependency(%q<blankslate>, [">= 2.1.2"])
  end
end
