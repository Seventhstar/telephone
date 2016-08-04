class AddComponentToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :component_id, :integer
  end
end
