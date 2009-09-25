require 'cases/helper'
require 'models/artist'

class HasManyIntegerAssociationTest < ActiveRecord::TestCase
  fixtures :labels
  fixtures :artists

  def test_has_many_artists
    label = labels(:def_jam)
    artists = label.artists
    assert_equal 4, artists.size
    artists.each do |artist|
      assert artist.instance_of?(Artist)
    end
  end
end
