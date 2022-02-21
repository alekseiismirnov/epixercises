class AddDateToSight < ActiveRecord::Migration[5.2]
  def change
    add_column :sights, :date, :date
  end
end
