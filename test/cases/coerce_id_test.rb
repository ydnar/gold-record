require 'cases/helper'
require 'models/artist'

class CoerceIdTest < ActiveRecord::TestCase
  def test_coerce_id_with_nil
    assert_equal nil, Artist.coerce_id(nil)
  end

  def test_coerce_id_with_false
    assert_equal false, Artist.coerce_id(false)
  end

  def test_coerce_id_with_integer
    assert_equal 12345, Artist.coerce_id(12345)
  end

  def test_coerce_id_with_empty_string
    assert_equal "", Artist.coerce_id("")
  end

  def test_coerce_id_with_bogus_string
    assert_equal "BOGUS", Artist.coerce_id("BOGUS")
  end

  def test_coerce_id_with_22_character_bogus_string
    assert_equal nil, Artist.coerce_id("~" * 22)
  end

  def test_coerce_id_with_36_character_bogus_string
    assert_equal nil, Artist.coerce_id("~" * 36)
  end

  def test_coerce_id_with_binary_uuid
    assert_equal NULL_UUID_RAW, Artist.coerce_id(NULL_UUID_RAW)
  end

  def test_coerce_id_with_hex_uuid
    assert_equal NULL_UUID_RAW, Artist.coerce_id(NULL_UUID_HEX)
  end

  def test_coerce_id_with_base64_uuid
    assert_equal NULL_UUID_RAW, Artist.coerce_id(NULL_UUID_BASE64)
  end
end
