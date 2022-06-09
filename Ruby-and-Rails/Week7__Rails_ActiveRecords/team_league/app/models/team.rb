class Team < ApplicationRecord
  has_many :players
  has_one :coordinator

  has_many :winner_games, foreign_key: :winner_id, class_name: 'Game', dependent: :destroy
  has_many :loser_games, foreign_key: :loser_id, class_name: 'Game', dependent: :destroy 
end
