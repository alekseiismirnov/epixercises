class AddForeignKeyToSights < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :sights, :animals
  end
end
