class AddRoomToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :room, :string
  end
end
