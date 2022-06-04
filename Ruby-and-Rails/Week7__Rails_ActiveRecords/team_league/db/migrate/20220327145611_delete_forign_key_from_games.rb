class DeleteForignKeyFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :games, :teams
  end
end
