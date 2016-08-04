class CreateMobiles < ActiveRecord::Migration
  def change
    create_table :mobiles do |t|
      t.string :name
      t.string :number
      t.integer :otdel_id
      t.integer :position_id

      t.timestamps
    end
  end
end
