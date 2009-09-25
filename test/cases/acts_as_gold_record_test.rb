require 'cases/helper'
require 'models/label'
require 'models/artist'
require 'models/album'
require 'models/song'
require 'models/fan'

class ActsAsGoldRecordTest < ActiveRecord::TestCase
  def test_label_does_not_identify_as_gold_record
    assert !Label.respond_to?(:gold_record?)
  end
  
  def test_artist_identifies_as_gold_record
    assert Artist.respond_to?(:gold_record?)
    assert Artist.gold_record?
  end
  
  def test_album_identifies_as_gold_record
    assert Album.respond_to?(:gold_record?)
    assert Album.gold_record?
  end
  
  def test_song_identifies_as_gold_record
    assert Song.respond_to?(:gold_record?)
    assert Song.gold_record?
  end
  
  def test_fan_identifies_as_gold_record
    assert Fan.respond_to?(:gold_record?)
    assert Fan.gold_record?
  end
end
