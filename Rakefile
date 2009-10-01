require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'

require File.join(File.dirname(__FILE__), 'lib', 'gold_record', 'version')
require File.expand_path(File.dirname(__FILE__)) + '/test/config'

PKG_BUILD     = ENV['PKG_BUILD'] ? '.' + ENV['PKG_BUILD'] : ''
PKG_NAME      = 'gold-record'
PKG_VERSION   = GoldRecord::VERSION::STRING + PKG_BUILD
PKG_FILE_NAME = "#{PKG_NAME}-#{PKG_VERSION}"

GEM_SPEC_NAME = File.join(File.dirname(__FILE__), "#{PKG_NAME}-#{PKG_VERSION}.gemspec")
GEM_NAME      = File.join(File.dirname(__FILE__), "#{PKG_NAME}-#{PKG_VERSION}.gem")

RELEASE_NAME  = "REL #{PKG_VERSION}"

RUBY_FORGE_PROJECT = "gold-record"
RUBY_FORGE_USER    = "ydnar"

MYSQL_DB_USER = 'root'

PKG_FILES = FileList[
    "lib/**/*", "test/**/*", "doc/**/*", "[A-Z]*",
    "HISTORY.rdoc", "README.rdoc",
    "Rakefile"
]

desc 'Run unit tests by default'
task :default => :test

Rake::TestTask.new(:test) { |t|
  t.libs << 'test'
  t.test_files = Dir.glob( "test/cases/**/*_test.rb" ).sort
  t.verbose = true
}

namespace :mysql do
  desc 'Build the MySQL test databases'
  task :build_databases do
    %x( echo "create DATABASE gold_record_test DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci " | mysql --user=#{MYSQL_DB_USER})
  end

  desc 'Drop the MySQL test databases'
  task :drop_databases do
    %x( mysqladmin --user=#{MYSQL_DB_USER} -f drop gold_record_test )
  end

  desc 'Rebuild the MySQL test databases'
  task :rebuild_databases => [:drop_databases, :build_databases]
end

task :build_mysql_databases => 'mysql:build_databases'
task :drop_mysql_databases => 'mysql:drop_databases'
task :rebuild_mysql_databases => 'mysql:rebuild_databases'


# Generate the RDoc documentation

Rake::RDocTask.new { |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = "GoldRecord -- Object-relation mapping put on rails"
  rdoc.options << '--line-numbers' << '--inline-source' << '-A cattr_accessor=object'
  rdoc.options << '--charset' << 'utf-8'
  rdoc.template = ENV['template'] ? "#{ENV['template']}.rb" : '../doc/template/horo'
  rdoc.rdoc_files.include('README.txt', 'HISTORY.rdoc', 'LICENSE.txt')
  rdoc.rdoc_files.include('lib/**/*.rb')
}


# Create compressed packages

dist_dirs = [ "lib", "test" ]

spec = Gem::Specification.new do |s|
  s.name = PKG_NAME
  s.version = PKG_VERSION
  s.summary = "Binary UUID support for ActiveRecord"
  s.description = "Unobtrusive binary UUID support for ActiveRecord. Supports migrations, reflections, assocations and SchemaDumper."
  s.author = "Randy Reddig"
  s.email = "randy@shaderlab.com"
  s.homepage = "http://github.com/ydnar/gold-record"
  s.rubyforge_project = "gold-record"
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=

  s.extra_rdoc_files = ["HISTORY.rdoc", "LICENSE.txt", "README.rdoc"]
  s.files = [ "Rakefile", "LICENSE.txt", "README.rdoc", "HISTORY.rdoc" ]
  dist_dirs.each do |dir|
    s.files = s.files + Dir.glob( "#{dir}/**/*" )
  end
  
  s.has_rdoc = true
  s.rdoc_options.concat ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.5"

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3.4"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_runtime_dependency(%q<uuidtools>, [">= 2.0.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.3.4"])
      s.add_dependency(%q<activesupport>, [">= 2.3.4"])
      s.add_dependency(%q<uuidtools>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.3.4"])
    s.add_dependency(%q<activesupport>, [">= 2.3.4"])
    s.add_dependency(%q<uuidtools>, [">= 2.0.0"])
  end
end

namespace :gem do
  desc "Print gemspec"
  task :spec do
    open GEM_SPEC_NAME, "wb" do |file|
      file.write(spec.to_ruby)
    end
  end
  
  desc "Build gem with Gemcutter"
  task :build => :spec do
    system "gem build #{GEM_SPEC_NAME}"
  end
  
  desc "Push gem to Gemcutter"
  task :push => :build do
    system "gem push #{GEM_NAME}"
  end
end
