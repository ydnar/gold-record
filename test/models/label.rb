# This is not a GoldRecord. It uses autoincrement primary keys.
class Label < ActiveRecord::Base
  has_many :artists
  has_many :albums, :through => :artists
  has_and_belongs_to_many :record_stores
end
