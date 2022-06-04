class CreateGamesTeamsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :games_teams do |t|
      t.belongs_to :games
      t.belongs_to :teams
    end
  end
end
