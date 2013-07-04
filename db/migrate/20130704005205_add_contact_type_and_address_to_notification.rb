class AddContactTypeAndAddressToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :contact_type, :string
    add_column :notifications, :address, :string
  end
end
