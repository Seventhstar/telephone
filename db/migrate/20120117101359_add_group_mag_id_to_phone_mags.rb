class AddGroupMagIdToPhoneMags < ActiveRecord::Migration
  def change
    add_column :phone_mags, :group_mag_id, :integer
  end
end
