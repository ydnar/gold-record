require 'cases/helper'

class UrlSafeBase64Test < ActiveRecord::TestCase
  def test_encode_with_nil
    assert_raise TypeError do
      GoldRecord::UUID.urlsafe_encode64(nil)
    end
  end

  def test_encode_with_false
    assert_raise TypeError do
      GoldRecord::UUID.urlsafe_encode64(false)
    end
  end

  def test_encode_with_number
    assert_raise TypeError do
      GoldRecord::UUID.urlsafe_encode64(12345)
    end
  end

  def test_encode_with_null_string
    assert_equal "A" * 22, GoldRecord::UUID.urlsafe_encode64("\000" * 16)
  end

  def test_encode_omits_padding_characters
    assert_no_match /[=]/, GoldRecord::UUID.urlsafe_encode64("\001" * 16)
  end

  def test_encode_omits_newlines
    assert_no_match /[\r\n]/, GoldRecord::UUID.urlsafe_encode64("\002" * 16)
  end
  
  def test_translation_of_plus_characters
    encoded = GoldRecord::UUID.urlsafe_encode64("\x7e" * 16)
    assert_no_match /[+]/, encoded
    assert_equal "fn5-fn5-fn5-fn5-fn5-fg", encoded
  end
  
  def test_translation_of_slash_characters
    encoded = GoldRecord::UUID.urlsafe_encode64("\x7f" * 16)
    assert_no_match /\//, encoded
    assert_equal "f39_f39_f39_f39_f39_fw", encoded
  end

  def test_decode_with_nil
    assert_raise NoMethodError do
      GoldRecord::UUID.urlsafe_decode64(nil)
    end
  end

  def test_decode_with_false
    assert_raise NoMethodError do
      GoldRecord::UUID.urlsafe_decode64(false)
    end
  end

  def test_decode_with_number
    assert_raise NoMethodError do
      GoldRecord::UUID.urlsafe_decode64(12345)
    end
  end

  def test_decode_with_null_string
    assert_equal "\000" * 16, GoldRecord::UUID.urlsafe_decode64("A" * 22)
  end

  def test_decode_with_short_strings
    assert_equal "", GoldRecord::UUID.urlsafe_decode64("A")
    assert_equal "\000", GoldRecord::UUID.urlsafe_decode64("AA")
    assert_equal "\000\000", GoldRecord::UUID.urlsafe_decode64("AAA")
    assert_equal "\000\000\000", GoldRecord::UUID.urlsafe_decode64("AAAA")
    assert_equal "\000\000\000", GoldRecord::UUID.urlsafe_decode64("AAAAA")
    assert_equal "\000\000\000\000", GoldRecord::UUID.urlsafe_decode64("AAAAAA")
  end
  
  def test_symmetry
    [
      "A" * 22,
      "BBBBBBBBBBBBBBBBBBBBBA",
      "CCCCCCCCCCCCCCCCCCCCCA",
      "aaaaaaaaaaaaaaaaaaaaaQ",
      "bbbbbbbbbbbbbbbbbbbbbQ",
      "cccccccccccccccccccccQ",
      "---------------------w",
      "_____________________w",
    ].each do |value|
      assert_equal value, GoldRecord::UUID.urlsafe_encode64(GoldRecord::UUID.urlsafe_decode64(value))
    end
  end
end
