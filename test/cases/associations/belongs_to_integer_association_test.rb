require 'cases/helper'
require 'models/artist'

class BelongsToIntegerAssociationTest < ActiveRecord::TestCase
  fixtures :labels
  fixtures :artists

  def test_belongs_to_with_integer_foreign_key
    artist = artists(:beatles)
    label = labels(:emi)
    assert_equal label, artist.label
  end
end
