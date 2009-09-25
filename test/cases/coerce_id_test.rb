require 'cases/helper'
require 'models/artist'

class CoerceIdTest < ActiveRecord::TestCase
  def test_coerce_id_exists
    assert Artist.respond_to?(:coerce_id)
  end

  def test_coerce_id_with_binary_uuid
    assert_equal Artist.coerce_id(NULL_UUID_RAW), NULL_UUID_RAW
  end
end
