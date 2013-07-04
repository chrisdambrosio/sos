class AddNotificationToLogEntry < ActiveRecord::Migration
  def change
    add_reference :log_entries, :notification, index: true
  end
end
