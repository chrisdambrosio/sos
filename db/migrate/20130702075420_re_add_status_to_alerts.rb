class ReAddStatusToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :status, :integer
    add_index  :alerts, :status
  end
end
