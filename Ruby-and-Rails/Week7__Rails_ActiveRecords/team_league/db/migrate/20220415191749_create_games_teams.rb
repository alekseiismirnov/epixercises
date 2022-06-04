class CreateGamesTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :games_teams do |t|
      t.column(:winner_id, :integer)
      t.column(:loser_id, :integer)
    end
  end
end
