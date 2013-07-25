class AddNameToScheduleLayer < ActiveRecord::Migration
  def change
    add_column :schedule_layers, :name, :string
  end
end
