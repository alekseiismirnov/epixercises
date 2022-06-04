class DropGamesTeamsTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :games_teams
  end
end
