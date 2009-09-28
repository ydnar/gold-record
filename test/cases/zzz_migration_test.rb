# The filename begins with "zzz" to ensure this is the last test.
require 'cases/helper'
require 'models/label'
require 'models/artist'
require 'models/record_store'

if ActiveRecord::Base.connection.supports_migrations?

class MigrationTest < ActiveRecord::TestCase
  fixtures :labels
  fixtures :artists
  fixtures :record_stores

  def test_migrations
    migrate_up
    reset
    run_tests
    
    migrate_down
    reset
    run_tests
  end

private

  def run_tests
    artist = artists(:beatles)
    label = labels(:emi)
    assert_equal label, artist.label
    
    label = labels(:def_jam)
    artists = label.artists
    assert_equal 4, artists.size
    artists.each do |artist|
      assert artist.instance_of?(Artist)
    end
    
    record_store = record_stores(:amoeba)
    labels = record_store.labels
    assert_equal 4, labels.size
    labels.each do |labels|
      assert labels.instance_of?(Label)
    end
    
    record_store = record_stores(:amoeba)
    artists = record_store.artists
    assert_equal 6, artists.size
    artists.each do |artists|
      assert artists.instance_of?(Artist)
    end
  end

  def reset
    [Label, Artist, RecordStore].each do |model|
      model.reset_column_information
    end
    ActiveRecord::Base.connection.clear_query_cache
  end
  
  def migrate_up
    # Change each int(11) id column to binary(16).
    # This preserves the column’s original value as a right-padded 16-byte string.
    [:labels, :record_stores].each do |table|
      ActiveRecord::Base.connection.change_integer_primary_key_to_uuid(table)
    end

    # Change association columns to binary(16).
    [
      [:artists, :label_id, :id],
      [:labels_record_stores, :label_id, false],
      [:labels_record_stores, :record_store_id, false],
      [:artists_record_stores, :record_store_id, false],
    ].each do |table, column, primary_key|
      ActiveRecord::Base.connection.change_integer_to_uuid(table, column, primary_key)
    end
  end
  
  def migrate_down    
    # Change each binary(16) id column to int(11).
    # MySQL casts the string value to an integer.
    [:labels, :record_stores].each do |table|
      ActiveRecord::Base.connection.change_uuid_to_integer_primary_key(table)
    end

    # Change association columns to int(11).
    [
      [:artists, :label_id, :id],
      [:labels_record_stores, :label_id, false],
      [:labels_record_stores, :record_store_id, false],
      [:artists_record_stores, :record_store_id, false],
    ].each do |table, column, primary_key|
      ActiveRecord::Base.connection.change_uuid_to_integer(table, column, primary_key)
    end
  end
end

end
