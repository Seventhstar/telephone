class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name
      t.text :description
      t.string :path_1c
      t.string :path_fs

      t.timestamps null: false
    end
  end
end
