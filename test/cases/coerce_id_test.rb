require 'cases/helper'
require 'models/artist'

class CoerceIdTest < ActiveRecord::TestCase
  def test_coerce_id_with_nil
    assert_nil Artist.coerce_id(nil)
  end

  def test_coerce_id_with_bogus_data
    assert_nil Artist.coerce_id("BOGUS")
  end

  def test_coerce_id_with_binary_uuid
    assert_equal Artist.coerce_id(NULL_UUID_RAW), NULL_UUID_RAW
  end

  def test_coerce_id_with_hex_uuid
    assert_equal Artist.coerce_id(NULL_UUID.to_s), NULL_UUID_RAW
  end
end
