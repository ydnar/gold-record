require 'cases/helper'
require 'models/record_store'
require 'models/label'

class HabtmIntegerToIntegerAssociationTest < ActiveRecord::TestCase
  fixtures :record_stores
  fixtures :labels

  def test_association_find
    record_store = record_stores(:amoeba)
    labels = record_store.labels
    assert_equal 4, labels.size
    labels.each do |labels|
      assert labels.instance_of?(Label)
    end
  end
  
  def test_empty_assocation_find
    record_store = record_stores(:tower)
    labels = record_store.labels
    assert_equal 0, labels.size
  end
end
