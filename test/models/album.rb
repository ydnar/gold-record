class Album < ActiveRecord::Base
  acts_as_gold_record
  belongs_to :artist
  has_many :songs
end
