class AddKeysTeamsToGames < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :games, :teams, column: :winner_id, primary_key: :id
    add_foreign_key :games, :teams, column: :loser_id, primary_key: :id
  end
end
