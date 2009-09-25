class Song < ActiveRecord::Base
  acts_as_gold_record
  belongs_to :album
  has_one :artist, :through => :album
end
