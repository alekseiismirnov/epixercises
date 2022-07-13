class CreateJoinTableEmployeeProject < ActiveRecord::Migration[6.0]
  def change
    create_join_table :employees, :projects do |t|
      t.index :employee_id
      t.index :project_id
    end
  end
end
