class CreateAdvices < ActiveRecord::Migration[7.1]
  def change
    create_table :advices do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_on, null: false
      t.text :content, null: false
      t.timestamps
    end

    add_index :advices, [:user_id, :date_on], unique: true
  end
end


