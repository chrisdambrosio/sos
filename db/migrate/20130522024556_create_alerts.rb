class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :description
      t.text :details

      t.timestamps
    end
  end
end
