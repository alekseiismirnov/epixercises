class AddForeignKeyTeamToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :players, :teams
  end
end
