class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
    end

    add_reference :employees, :division, foreghn_key: true
  end
end
