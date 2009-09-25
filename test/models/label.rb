class Label < ActiveRecord::Base
  # This is not a GoldRecord. It uses autoincrement primary keys.
  has_many :artists
end
