class CreateDivisionsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :divisions do |t|
      t.string :name
    end
  end
end
