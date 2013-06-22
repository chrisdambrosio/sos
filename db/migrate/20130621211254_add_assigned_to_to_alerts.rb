class AddAssignedToToAlerts < ActiveRecord::Migration
  def change
    add_column :alerts, :assigned_to, :integer
  end
end
