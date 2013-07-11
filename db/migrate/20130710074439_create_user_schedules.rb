class CreateUserSchedules < ActiveRecord::Migration
  def change
    create_table :user_schedules do |t|
      t.references :user, index: true
      t.integer :position
      t.references :schedule_layer, index: true

      t.timestamps
    end
  end
end
