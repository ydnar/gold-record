require 'cases/helper'
require 'models/artist'
require 'models/fan'

class HabtmUuidToUuidAssociationTest < ActiveRecord::TestCase
  fixtures :artists
  fixtures :fans

  def test_association_find
    artist = artists(:beatles)
    fans = artist.fans
    assert_equal 8, fans.size
    fans.each do |fans|
      assert fans.instance_of?(Fan)
    end
  end
  
  def test_empty_assocation_find
    artist = artists(:ll_cool_j)
    fans = artist.fans
    assert_equal 0, fans.size
  end
end
