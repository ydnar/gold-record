require 'cases/helper'
require 'models/label'
require 'models/artist'

class ActsAsGoldRecordTest < ActiveRecord::TestCase
  def test_label_does_not_identify_as_gold_record
    assert !Label.respond_to?(:gold_record?)
  end
  
  def test_artist_identifies_as_gold_record
    assert Artist.respond_to?(:gold_record?)
    assert Artist.gold_record?
  end
end
