class NewPhonefield < ActiveRecord::Migration
  def up
    change_table :phones do |t|
      t.string  :number
    end

  end

  def down
  end


end
