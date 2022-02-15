class Sight < ApplicationRecord
  belongs_to :animal
  belongs_to :region

  def latitude
    location.x
  end

  def longtitude
    location.y
  end
end
