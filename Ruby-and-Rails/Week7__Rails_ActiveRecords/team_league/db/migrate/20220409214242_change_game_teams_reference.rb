class ChangeGameTeamsReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :games_teams, :team_id
    add_column :games_teams, :winner_id, :integer
    add_column :games_teams, :loser_id, :integer
  end
end
