class AddForeignKeyRegionToSights < ActiveRecord::Migration[5.2]
  def change
    add_column :sights, :region_id, :integer
    add_foreign_key :sights, :regions
  end
end
