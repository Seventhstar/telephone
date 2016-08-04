class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :priority_id
      t.integer :user_id
      t.integer :state_id
      t.integer :task_type_id
      t.integer :dept_id
      t.date :place_date
      t.date :start_date
      t.date :end_date
      t.integer :cur_order

      t.timestamps null: false
    end
  end
end
