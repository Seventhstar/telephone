class CreatePhoneMags < ActiveRecord::Migration
  def change
    create_table :phone_mags do |t|
      t.string :name
      t.string :fio
      t.string :number
      t.string :email
      t.string :mobile
      t.string :work_time

      t.timestamps
    end
  end
end
