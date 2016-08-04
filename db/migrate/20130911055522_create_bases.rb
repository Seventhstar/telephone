class CreateBases < ActiveRecord::Migration
  def change
    create_table :bases do |t|
      t.text :service_text
      t.boolean :maintenance

      t.timestamps
    end
  end
end
