class ChangeCoordinatorToCoordinators < ActiveRecord::Migration[6.0]
  def change
    rename_table :coordinator, :coordinators
  end
end
