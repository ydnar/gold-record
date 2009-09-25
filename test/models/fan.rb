class Fan < ActiveRecord::Base
  acts_as_gold_record
  has_and_belongs_to_many :artists
end
