class AddTeamCoordinator < ActiveRecord::Migration[6.0]
  def change
    create_table :coordinator do |t|
      t.column(:name, :string)
      t.column(:contacts, :string)
      t.references(:team, foreighn_key: {to_table: :team})
    end
  end
end
