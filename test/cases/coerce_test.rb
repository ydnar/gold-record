require 'cases/helper'

class CoerceTest < ActiveRecord::TestCase
  def test_coerce_with_nil
    assert_equal nil, GoldRecord::UUID.coerce(nil)
  end

  def test_coerce_with_false
    assert_equal nil, GoldRecord::UUID.coerce(false)
  end

  def test_coerce_with_integer
    assert_equal nil, GoldRecord::UUID.coerce(12345)
  end

  def test_coerce_with_empty_string
    assert_equal nil, GoldRecord::UUID.coerce("")
  end

  def test_coerce_with_bogus_string
    assert_equal nil, GoldRecord::UUID.coerce("BOGUS")
  end

  def test_coerce_with_22_character_bogus_string
    assert_equal nil, GoldRecord::UUID.coerce("~" * 22)
  end

  def test_coerce_with_36_character_bogus_string
    assert_equal nil, GoldRecord::UUID.coerce("~" * 36)
  end

  def test_coerce_with_binary_uuid
    assert_equal NULL_UUID_RAW, GoldRecord::UUID.coerce(NULL_UUID_RAW)
  end

  def test_coerce_with_hex_uuid
    assert_equal NULL_UUID_RAW, GoldRecord::UUID.coerce(NULL_UUID_HEX)
  end

  def test_coerce_with_base64_uuid
    assert_equal NULL_UUID_RAW, GoldRecord::UUID.coerce(NULL_UUID_BASE64)
  end
end
