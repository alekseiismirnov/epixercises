class RenameIdsInGamesTeams < ActiveRecord::Migration[6.0]
  def change
    rename_column(:games_teams, :games_id, :game_id)
    rename_column(:games_teams, :teams_id, :team_id)
  end
end
