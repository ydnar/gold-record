require 'cases/helper'

class RandomGenerateTest < ActiveRecord::TestCase
  def test_size_of_generated_string
    1000.times do
      assert_equal 16, GoldRecord::UUID.random_generate.size
    end
  end
  
  # 00000000-0000-4000-8000-000000000000
  # ffffffff-ffff-4fff-bfff-ffffffffffff
  
  def test_version_nibble
    1000.times do
      value = GoldRecord::UUID.random_generate
      assert_equal (value[6] & 0xf0), 0x40
    end
  end

  def test_reserved_bits
    1000.times do
      value = GoldRecord::UUID.random_generate
      assert_equal (value[8] & 0x80), 0x80
      assert_equal (value[8] & 0x40), 0x00
    end
  end
  
  def test_randomness # This is kind of weak.
    cache = {}
    1000.times do
      value = GoldRecord::UUID.random_generate
      assert !cache.has_key?(value)
      cache[value] = true
    end
  end
end
