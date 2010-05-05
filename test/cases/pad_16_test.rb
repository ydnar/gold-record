require 'cases/helper'

class Pad16Test < ActiveRecord::TestCase  
  def test_coerce_with_nil
    assert_equal "0#{"\000" * 15}", GoldRecord::UUID.pad_16(nil)
  end

  def test_coerce_with_false
    assert_raise TypeError do
      GoldRecord::UUID.pad_16(false)
    end
  end

  def test_coerce_with_empty_string
    assert_raise ArgumentError do
      GoldRecord::UUID.pad_16("")
    end
  end

  def test_coerce_with_bogus_string
    assert_raise ArgumentError do
      assert_equal "0#{"\000" * 15}", GoldRecord::UUID.pad_16("BOGUS")
    end
  end

  def test_coerce_with_small_integer
    assert_equal "1#{"\000" * 15}", GoldRecord::UUID.pad_16(1)
  end

  def test_coerce_with_medium_integer
    assert_equal "12345#{"\000" * 11}", GoldRecord::UUID.pad_16(12345)
  end

  def test_coerce_with_large_integer
    assert_equal "1234567890#{"\000" * 6}", GoldRecord::UUID.pad_16(1234567890)
  end
end
