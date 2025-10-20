class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :property, null: false, foreign_key: true
      t.text :description
      t.string :task_type
      t.string :assigned_person
      t.string :status
      t.date :date

      t.timestamps
    end
  end
end
