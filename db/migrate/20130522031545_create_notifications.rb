class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :contact_method, index: true
      t.references :alert, index: true

      t.timestamps
    end
  end
end
