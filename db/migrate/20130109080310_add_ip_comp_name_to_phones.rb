class AddIpCompNameToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :IP, :string
    add_column :phones, :CompName, :string
  end
end
