ActiveRecord::Schema.define do
  # Label (with integer ID)
  create_table :labels, :force => true do |t|
    t.string :name
  end
  
  # RecordStore (with integer ID)
  create_table :record_stores, :force => true do |t|
    t.string :name
  end

  # Artist
  create_table :artists, :force => true, :id => false do |t|
    t.binary :id, :limit => 16
    t.integer :label_id
    t.string :name
  end

  # Album
  create_table :albums, :force => true, :id => false do |t|
    t.binary :id, :limit => 16
    t.binary :artist_id, :limit => 16
    t.string :name
  end

  # Song
  create_table :songs, :force => true, :id => false do |t|
    t.binary :id, :limit => 16
    t.binary :album_id, :limit => 16
    t.string :name
  end

  # Fan
  create_table :fans, :force => true, :id => false do |t|
    t.binary :id, :limit => 16
    t.string :name
  end

  # HABTM (with two UUIDs)
  create_table :artists_fans, :force => true, :id => false do |t|
    t.binary :artist_id, :limit => 16
    t.binary :fan_id, :limit => 16
  end

  # HABTM (with two integers)
  create_table :labels_record_stores, :force => true, :id => false do |t|
    t.integer :label_id
    t.integer :record_store_id
  end

  # HABTM (with and integer and UUID)
  create_table :artists_record_stores, :force => true, :id => false do |t|
    t.binary :artist_id, :limit => 16
    t.integer :record_store_id
  end
end
