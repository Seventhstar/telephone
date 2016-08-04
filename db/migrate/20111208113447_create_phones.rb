class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :name
      t.integer :otdel_id
      t.integer :position_id

      t.timestamps
    end
  end
end
