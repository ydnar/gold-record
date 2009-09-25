require 'cases/helper'
require 'models/artist'

class GenerateIdTest < ActiveRecord::TestCase
  fixtures :artists

  def test_generate_id_for_new_record
    artist = Artist.new
    assert artist.new_record?
    assert_nil artist.id
    artist.generate_id!
    assert artist.id.instance_of?(String)
    assert_equal artist.id.size, 16
  end
end
