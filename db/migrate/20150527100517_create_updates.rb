class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :name
      t.string :path
      t.string :current

      t.timestamps null: false
    end
  end
end
