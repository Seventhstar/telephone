class AddHoursToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :hours_plan, :integer
    add_column :tasks, :hours_fact, :integer
  end
end
