require 'cases/helper'
require 'models/artist'

class FindTest < ActiveRecord::TestCase
  fixtures :artists

  def test_find_with_one_binary_uuid
    artist = Artist.find identify(:michael_jackson)
    assert_equal artist.class, Artist
  end

  def test_find_with_one_hex_uuid
    artist = Artist.find identify_hex(:michael_jackson)
    assert_equal artist.class, Artist
  end

  def test_find_with_multiple_binary_uuids
    artists = Artist.find([
      identify(:beatles),
      identify(:michael_jackson),
      identify(:warren_g),
    ])
    assert_equal artists.size, 3
    artists.each do |artist|
      assert_equal artist.class, Artist
    end
  end
end
