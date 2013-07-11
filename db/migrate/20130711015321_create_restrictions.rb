class CreateRestrictions < ActiveRecord::Migration
  def change
    create_table :restrictions do |t|
      t.references :schedule_layer, index: true
      t.integer :start_day_of_week
      t.integer :end_day_of_week
      t.integer :start_time_of_day
      t.integer :end_time_of_day

      t.timestamps
    end
  end
end
