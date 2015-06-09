class Place < ActiveRecord::Base
  has_many :pictures
  reverse_geocoded_by :latitude, :longitude
end
