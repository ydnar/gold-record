require 'cases/helper'
require 'models/artist'

class CoerceIdTest < ActiveRecord::TestCase
  def test_coerce_id_exists
    assert Artist.respond_to?(:coerce_id)
  end
end
