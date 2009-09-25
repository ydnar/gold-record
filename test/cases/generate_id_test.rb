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
    assert_equal 16, artist.id.size
  end

  def test_generate_id_for_existing_record
    artist = Artist.first
    assert !artist.new_record?
    assert artist.id.instance_of?(String)
    assert_equal 16, artist.id.size
    id = artist.id
    artist.generate_id!
    assert_equal artist.id, id
  end
end
