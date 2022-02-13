class Sight < ApplicationRecord
  belongs_to :animal

  def latitude
    location.x
  end

  def longtitude
    location.y
  end
end
