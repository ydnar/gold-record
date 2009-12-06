require 'cases/helper'

class HexTest < ActiveRecord::TestCase
  def test_encode_with_nil
    assert_raise NoMethodError do
      GoldRecord::UUID.encode_hex(nil)
    end
  end

  def test_encode_with_false
    assert_raise NoMethodError do
      GoldRecord::UUID.encode_hex(false)
    end
  end

  def test_encode_with_number
    assert_raise NoMethodError do
      GoldRecord::UUID.encode_hex(12345)
    end
  end

  def test_encode_with_null_string
    assert_equal "0" * 32, GoldRecord::UUID.encode_hex("\000" * 16)
  end

  def test_decode_with_nil
    assert_raise NoMethodError do
      GoldRecord::UUID.decode_hex(nil)
    end
  end

  def test_decode_with_false
    assert_raise NoMethodError do
      GoldRecord::UUID.decode_hex(false)
    end
  end

  def test_decode_with_number
    assert_raise NoMethodError do
      GoldRecord::UUID.decode_hex(12345)
    end
  end

  def test_decode_with_null_string
    assert_equal "\000" * 16, GoldRecord::UUID.decode_hex("0" * 32)
  end

  def test_decode_with_short_strings
    assert_equal "\000", GoldRecord::UUID.decode_hex("0")
    assert_equal "\000", GoldRecord::UUID.decode_hex("00")
    assert_equal "\000\000", GoldRecord::UUID.decode_hex("000")
    assert_equal "\000\000", GoldRecord::UUID.decode_hex("0000")
    assert_equal "\000\000\000", GoldRecord::UUID.decode_hex("00000")
    assert_equal "\000\000\000", GoldRecord::UUID.decode_hex("000000")
  end
  
  def test_symmetry
    [
      "a" * 32,
      "b" * 32,
    ].each do |value|
      assert_equal value, GoldRecord::UUID.encode_hex(GoldRecord::UUID.decode_hex(value))
    end
  end
end
