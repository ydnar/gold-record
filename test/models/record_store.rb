# This is not a GoldRecord. It uses autoincrement primary keys.
class RecordStore < ActiveRecord::Base
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :artists
end
