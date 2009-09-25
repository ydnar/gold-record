require 'cases/helper'
require 'models/artist'

class ActsAsGoldRecordTest < ActiveRecord::TestCase
  def test_identify_as_gold_record
    assert Artist.respond_to?(:gold_record?)
    assert Artist.gold_record?
  end
end
