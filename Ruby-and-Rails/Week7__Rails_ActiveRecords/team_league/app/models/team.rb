class Team < ApplicationRecord
  has_many :players
  has_one :coordinator
  has_many :games, as: :winner
end
