class CreateScheduleLayers < ActiveRecord::Migration
  def change
    create_table :schedule_layers do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :priority
      t.integer :rotation_duration

      t.timestamps
    end
  end
end
