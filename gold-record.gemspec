# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gold-record}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Randy Reddig"]
  s.autorequire = %q{gold_record}
  s.date = %q{2009-09-20}
  s.description = %q{Binary UUID support for ActiveRecord}
  s.email = ["randy@shaderlab.com"]
  s.extra_rdoc_files = ["HISTORY.rdoc", "LICENSE", "README.rdoc"]
  s.files = [
    "lib/gold_record.rb",
    "lib/gold_record/base.rb",
    "lib/gold_record/fixtures.rb",
    "lib/gold_record/connection_adapters/mysql_adapter.rb",
  ]
  s.homepage = %q{http://github.com/ydnar/gold-record}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{gold-record}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Binary UUID support for ActiveRecord}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_runtime_dependency(%q<uuidtools>, [">= 2.0.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_dependency(%q<uuidtools>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.4"])
    s.add_dependency(%q<uuidtools>, [">= 2.0.0"])
  end
end
