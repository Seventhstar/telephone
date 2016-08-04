class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :path

      t.timestamps null: false
    end
  end
end
