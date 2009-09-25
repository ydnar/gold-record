# The filename begins with "aaa" to ensure this is the first test.
require 'cases/helper'

class AAACreateTablesTest < ActiveRecord::TestCase
  self.use_transactional_fixtures = false

  def test_load_schema
    eval(File.read(SCHEMA_ROOT + "/schema.rb"))
    assert true
  end
end
