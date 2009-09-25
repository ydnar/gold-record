class Song < ActiveRecord::Base
  acts_as_gold_record
  belongs_to :album
  belongs_to :artist, :through => :album
end
