require 'cases/helper'

class RandomGenerateTest < ActiveRecord::TestCase
  def test_size_of_generated_string
    assert_equal 16, GoldRecord::UUID.random_generate.size
  end
  
  def test_randomness # This is kind of weak.
    cache = {}
    10000.times do
      value = GoldRecord::UUID.random_generate
      assert !cache.has_key?(value)
      cache[value] = true
    end
  end
end
