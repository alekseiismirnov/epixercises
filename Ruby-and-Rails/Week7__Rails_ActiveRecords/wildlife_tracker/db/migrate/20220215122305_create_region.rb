class CreateRegion < ActiveRecord::Migration[5.2]
  def change
    create_table :regions do |t|
      t.column(:name, :string)
    end
  end
end
