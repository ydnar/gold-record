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

  def test_encode_omits_padding_characters
    assert_no_match /[=]/, GoldRecord.urlsafe_encode64("\001" * 16)
  end

  def test_encode_omits_newlines
    assert_no_match /[\r\n]/, GoldRecord.urlsafe_encode64("\002" * 16)
  end
  
  def test_translation_of_plus_characters
    encoded = GoldRecord.urlsafe_encode64("\x7e" * 16)
    assert_no_match /[+]/, encoded
    assert_equal "fn5-fn5-fn5-fn5-fn5-fg", encoded
  end
  
  def test_translation_of_slash_characters
    encoded = GoldRecord.urlsafe_encode64("\x7f" * 16)
    assert_no_match /\//, encoded
    assert_equal "f39_f39_f39_f39_f39_fw", encoded
  end
end
