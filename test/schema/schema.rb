ActiveRecord::Schema.define do
  # Label (not a GoldRecord)
  create_table :labels, :force => true do |t|
    t.string :name
  end

  # Artist
  create_table :artists, :force => true, :id => false do |t|
    t.binary :id, :limit => 16
    t.integer :label_id
    t.string :name
  end

  # Fan
  create_table :fans, :force => true, :id => false do |t|
    t.binary :id, :limit => 16
    t.string :name
  end

  # HABTM
  create_table :artists_fans, :force => true, :id => false do |t|
    t.binary :artist_id, :limit => 16
    t.binary :fan_id, :limit => 16
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
end
