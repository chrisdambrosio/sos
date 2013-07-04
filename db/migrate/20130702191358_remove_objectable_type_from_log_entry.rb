class RemoveObjectableTypeFromLogEntry < ActiveRecord::Migration
  def change
    remove_column :log_entries, :subjectable_type
    remove_column :log_entries, :objectable_type
  end
end
