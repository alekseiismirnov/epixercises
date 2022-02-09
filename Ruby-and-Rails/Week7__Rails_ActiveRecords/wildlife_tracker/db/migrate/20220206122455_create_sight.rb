class CreateSight < ActiveRecord::Migration[5.2]
  def change
    create_table :sights do |t|
      t.column(:animal_id, :integer)
      t.column(:location, :point)
    end
  end
end
