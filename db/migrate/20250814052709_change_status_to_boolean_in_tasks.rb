class ChangeStatusToBooleanInTasks < ActiveRecord::Migration[7.1]
  def up
    add_column :tasks, :status_bool, :boolean, default: false, null: false

    execute <<~SQL.squish
      UPDATE tasks
      SET status_bool =
        CASE
          WHEN status = 1 OR status = '1' THEN TRUE
          ELSE FALSE
        END
    SQL

    remove_column :tasks, :status
    rename_column :tasks, :status_bool, :status
  end

  def down
    add_column :tasks, :status_int, :integer, default: 0, null: false

    execute <<~SQL.squish
      UPDATE tasks
      SET status_int = CASE WHEN status = TRUE THEN 1 ELSE 0 END
    SQL

    remove_column :tasks, :status
    rename_column :tasks, :status_int, :status
  end
end
