require 'cases/helper'
require 'models/artist'

class BelongsToIntegerAssociationTest < ActiveRecord::TestCase
  fixtures :labels
  fixtures :artists

  def test_association_find
    artist = artists(:beatles)
    label = labels(:emi)
    assert_equal label, artist.label
  end
end
