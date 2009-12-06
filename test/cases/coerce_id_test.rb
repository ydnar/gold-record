require 'cases/helper'
require 'models/artist'

class CoerceIdTest < ActiveRecord::TestCase
  def test_coerce_id_with_nil
    assert_nil Artist.coerce_id(nil)
  end

  def test_coerce_id_with_false
    assert_nil Artist.coerce_id(false)
  end

  def test_coerce_id_with_empty_string
    assert_nil Artist.coerce_id("")
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
