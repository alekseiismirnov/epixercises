class AddTeamsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :winner_id, :integer
    add_column :games, :loser_id, :integer
  end
end
