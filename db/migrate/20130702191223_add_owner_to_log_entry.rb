class AddOwnerToLogEntry < ActiveRecord::Migration
  def change
    add_reference :log_entries, :user, index: true
  end
end
