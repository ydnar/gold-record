require 'cases/helper'
require 'models/artist'

class HasManyUuidAssociationTest < ActiveRecord::TestCase
  fixtures :artists
  fixtures :albums

  def test_association_find
    artist = artists(:beatles)
    albums = artist.albums
    assert_equal 3, albums.size
    albums.each do |album|
      assert album.instance_of?(Album)
    end
  end
end
