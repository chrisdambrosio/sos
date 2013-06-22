class AddSendAtToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :send_at, :datetime
  end
end
