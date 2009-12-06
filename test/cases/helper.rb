$:.unshift(File.dirname(__FILE__) + '/../../lib')
$:.unshift(File.dirname(__FILE__) + '/../../../activesupport/lib')

require 'config'

require 'rubygems'
require 'test/unit'
require 'stringio'

require 'active_record'
require 'active_record/test_case'
require 'active_record/fixtures'
require 'connection'

require 'uuidtools'

require 'gold_record'

# Patch Fixtures
Fixtures.send :include, GoldRecord::Fixtures

# UUID composed of all null bytes
NULL_UUID_RAW = ("\000" * 16).freeze
NULL_UUID = UUIDTools::UUID.parse_raw(NULL_UUID_RAW).freeze
NULL_UUID_HEX = "00000000-0000-0000-0000-000000000000".freeze
NULL_UUID_BASE64 = "AAAAAAAAAAAAAAAAAAAAAA".freeze

# Show backtraces for deprecated behavior for quicker cleanup.
ActiveSupport::Deprecation.debug = true

# Quote "type" if it's a reserved word for the current connection.
QUOTED_TYPE = ActiveRecord::Base.connection.quote_column_name('type')

def current_adapter?(*types)
  types.any? do |type|
    ActiveRecord::ConnectionAdapters.const_defined?(type) &&
      ActiveRecord::Base.connection.is_a?(ActiveRecord::ConnectionAdapters.const_get(type))
  end
end

ActiveRecord::Base.connection.class.class_eval do
  IGNORED_SQL = [/^PRAGMA/, /^SELECT currval/, /^SELECT CAST/, /^SELECT @@IDENTITY/, /^SELECT @@ROWCOUNT/, /^SAVEPOINT/, /^ROLLBACK TO SAVEPOINT/, /^RELEASE SAVEPOINT/, /SHOW FIELDS/]

  def execute_with_query_record(sql, name = nil, &block)
    $queries_executed ||= []
    $queries_executed << sql unless IGNORED_SQL.any? { |r| sql =~ r }
    execute_without_query_record(sql, name, &block)
  end

  alias_method_chain :execute, :query_record
end

# Make with_scope public for tests
class << ActiveRecord::Base
  public :with_scope, :with_exclusive_scope
end

unless ENV['FIXTURE_DEBUG']
  module ActiveRecord::TestFixtures::ClassMethods
    def try_to_load_dependency_with_silence(*args)
      ActiveRecord::Base.logger.silence { try_to_load_dependency_without_silence(*args)}
    end

    alias_method_chain :try_to_load_dependency, :silence
  end
end

class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures

  self.fixture_path = FIXTURES_ROOT
  self.use_instantiated_fixtures  = false
  self.use_transactional_fixtures = true

  def create_fixtures(*table_names, &block)
    Fixtures.create_fixtures(ActiveSupport::TestCase.fixture_path, table_names, {}, &block)
  end
  
  def identify(label)
    Fixtures.identify(label)
  end
  
  def identify_uuid(label)
    UUIDTools::UUID.parse_raw(identify(label))
  end
  
  def identify_hex(label)
    identify_uuid(label).to_s
  end
  
  def identify_base64(label)
    raw = [identify_hex(label).gsub(/-/, '')].pack("H*")
    # puts "Label: #{label}"
    # puts "UUID:  #{identify_uuid(label)}"
    # puts "Raw:   #{raw.unpack("H*").first}"
    GoldRecord.urlsafe_encode64(raw)
  end
end
