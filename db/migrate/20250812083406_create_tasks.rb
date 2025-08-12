class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :content, null: false
      t.date :date_on, null: false
      t.integer :status, null: false
      t.timestamps
    end
  end
end
