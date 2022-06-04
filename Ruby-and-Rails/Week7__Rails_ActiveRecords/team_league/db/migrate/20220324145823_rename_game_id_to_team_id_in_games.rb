class RenameGameIdToTeamIdInGames < ActiveRecord::Migration[6.0]
  def change
    rename_column(:games, :game_id, :team_id)
  end
end
