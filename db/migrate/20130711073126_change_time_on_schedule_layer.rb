class ChangeTimeOnScheduleLayer < ActiveRecord::Migration
  def change
    change_column :schedule_layers, :start_time, :time
    change_column :schedule_layers, :end_time, :time
  end
end
