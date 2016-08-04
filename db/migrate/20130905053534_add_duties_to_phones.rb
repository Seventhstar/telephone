class AddDutiesToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :Duties, :text
  end
end
