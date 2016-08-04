class CreateDutiesSuggestions < ActiveRecord::Migration
  def change
    create_table :duties_suggestions do |t|
      t.string :term

      t.timestamps
    end
  end
end
