# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dsl_accessor}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["maiha"]
  s.date = %q{2009-01-24}
  s.description = %q{This plugin gives hybrid accessor class methods to classes by DSL like definition}
  s.email = %q{maiha@wota.jp}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["LICENSE", "README", "Rakefile", "core_ext/class", "core_ext/class/dsl_accessor.rb", "lib/dsl_accessor.rb", "spec/auto_declared_spec.rb", "spec/spec_helper.rb", "tasks/dsl_accessor_tasks.rake", "test/instance_test.rb", "test/default_test.rb", "test/writer_test.rb", "test/test_helper.rb", "test/dsl_accessor_test.rb", "test/instance_options_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/maiha/dsl_accessor}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{This plugin gives hybrid accessor class methods to classes by DSL like definition}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.0.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.0.0"])
  end
end
