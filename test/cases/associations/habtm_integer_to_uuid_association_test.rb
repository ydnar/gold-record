require 'cases/helper'
require 'models/record_store'
require 'models/artist'

class HabtmIntegerToIntegerAssociationTest < ActiveRecord::TestCase
  fixtures :record_stores
  fixtures :artists

  def test_association_find
    record_store = record_stores(:amoeba)
    artists = record_store.artists
    assert_equal 6, artists.size
    artists.each do |artists|
      assert artists.instance_of?(Artist)
    end
  end
  
  def test_empty_assocation_find
    record_store = record_stores(:tower)
    artists = record_store.artists
    assert_equal 0, artists.size
  end
end
