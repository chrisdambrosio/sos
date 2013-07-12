class AddScheduleToScheduleLayer < ActiveRecord::Migration
  def change
    add_reference :schedule_layers, :schedule, index: true
  end
end
