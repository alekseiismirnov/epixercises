class RemoveTeamId < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :team_id
  end
end
