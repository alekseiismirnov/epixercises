class AddForeignKeyToGames < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :games, :teams
  end
end
