class SetDefaultScoresTo0InGames < ActiveRecord::Migration[6.0]
  def change
    change_column_default :games, :scores, 0
  end
end
