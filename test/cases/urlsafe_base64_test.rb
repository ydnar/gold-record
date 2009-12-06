require 'cases/helper'

class UrlSafeBase64Test < ActiveRecord::TestCase
  def test_encode_with_nil
    assert_raise TypeError do
      GoldRecord.urlsafe_encode64(nil)
    end
  end

  def test_encode_with_false
    assert_raise TypeError do
      GoldRecord.urlsafe_encode64(false)
    end
  end

  def test_encode_with_number
    assert_raise TypeError do
      GoldRecord.urlsafe_encode64(12345)
    end
  end

  def test_encode_with_null_string
    assert_equal "AAAAAAAAAAAAAAAAAAAAAA", GoldRecord.urlsafe_encode64("\000" * 16)
  end
end
