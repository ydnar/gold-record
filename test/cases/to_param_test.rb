require 'cases/helper'
require 'models/artist'

class ToParamTest < ActiveRecord::TestCase
  fixtures :artists

  def test_to_param_returns_nil_for_new_record
    artist = Artist.new
    assert artist.new_record?
    param = artist.to_param
    assert_nil param
  end

  def test_to_param_returns_a_hex_string
    artist = Artist.first
    param = artist.to_param
    assert param.instance_of?(String)
    assert param.match(/\A[0-9a-f\-]{36}\z/)
  end
end
