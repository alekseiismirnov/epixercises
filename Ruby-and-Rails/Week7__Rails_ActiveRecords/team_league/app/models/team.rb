class Team < ApplicationRecord
  has_many :players
  has_one :coordinator
end
