class Artist < ActiveRecord::Base
  acts_as_gold_record
  belongs_to :label
  has_many :albums
  has_many :songs, :through => :albums
  has_and_belongs_to_many :fans
end
