class RedoTimeForScheduleLayer < ActiveRecord::Migration
  def change
    remove_column :schedule_layers, :start_time
    remove_column :schedule_layers, :end_time
    add_column :schedule_layers, :start_time, :datetime
    add_column :schedule_layers, :end_time, :datetime
  end
end
