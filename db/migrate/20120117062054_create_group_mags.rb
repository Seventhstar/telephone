class CreateGroupMags < ActiveRecord::Migration
  def change
    create_table :group_mags do |t|
      t.string :name

      t.timestamps
    end
  end
end
