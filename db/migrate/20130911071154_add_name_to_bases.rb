class AddNameToBases < ActiveRecord::Migration
  def change
    add_column :bases, :name, :string
    add_column :bases, :img_name, :string
  end
end
