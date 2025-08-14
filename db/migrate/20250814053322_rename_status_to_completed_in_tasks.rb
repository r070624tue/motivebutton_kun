class RenameStatusToCompletedInTasks < ActiveRecord::Migration[7.1]
  def change
    rename_column :tasks, :status, :completed
  end
end
