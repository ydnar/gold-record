require 'cases/helper'
require 'models/artist'

class ToUuidTest < ActiveRecord::TestCase
  fixtures :artists

  def test_to_uuid_exists
    artist = Artist.first
    assert artist.respond_to?(:to_uuid)
  end

  def test_to_uuid_returns_a_uuid
    artist = Artist.first
    uuid = artist.to_uuid
    assert uuid.instance_of?(UUIDTools::UUID)
  end
end
