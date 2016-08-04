class AddServerToBackup < ActiveRecord::Migration
  def change
    add_column :backups, :server_id, :integer
  end
end
