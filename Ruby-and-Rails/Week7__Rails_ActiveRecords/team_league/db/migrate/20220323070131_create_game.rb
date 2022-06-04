class CreateGame < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.column(:scores, :integer)
      t.column(:game_id, :integer)
    end
  end
end
