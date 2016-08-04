class CreateTaskDepts < ActiveRecord::Migration
  def change
    create_table :task_depts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
