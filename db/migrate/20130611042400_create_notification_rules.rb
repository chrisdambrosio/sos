class CreateNotificationRules < ActiveRecord::Migration
  def change
    create_table :notification_rules do |t|
      t.references :contact_method, index: true
      t.integer :start_delay

      t.timestamps
    end
  end
end
