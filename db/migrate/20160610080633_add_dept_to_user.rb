class AddDeptToUser < ActiveRecord::Migration
  def change
    add_column :users, :dept_id, :integer
  end
end
