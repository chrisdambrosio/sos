class RemoveStatusFromAlert < ActiveRecord::Migration
  def change
    remove_column :alerts, :status
  end
end
