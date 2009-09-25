require 'cases/helper'
require 'models/artist'

class ToUuidTest < ActiveRecord::TestCase
  fixtures :artists

  def test_to_uuid_returns_nil_for_new_record
    artist = Artist.new
    assert artist.new_record?
    uuid = artist.to_uuid
    assert_nil uuid
  end

  def test_to_uuid_returns_a_uuid
    artist = Artist.first
    uuid = artist.to_uuid
    assert uuid.instance_of?(UUIDTools::UUID)
  end

  def test_to_uuid_returns_the_correct_uuid
    artist = Artist.first
    uuid = artist.to_uuid
    assert_equal artist.id, uuid.raw
  end
end
