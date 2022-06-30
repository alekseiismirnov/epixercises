class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :order
    end
  end
end
