class RemoveObjectableFromLogEntry < ActiveRecord::Migration
  def change
    remove_column :log_entries, :subjectable_id, :subjectable_type
    remove_column :log_entries, :objectable_id, :objectable_type
  end
end
