require 'cases/helper'
require 'models/artist'

class BelongsToUuidAssociationTest < ActiveRecord::TestCase
  fixtures :artists
  fixtures :albums

  def test_association_find
    album = albums(:white_album)
    artist = artists(:beatles)
    assert_equal artist, album.artist
  end
end
