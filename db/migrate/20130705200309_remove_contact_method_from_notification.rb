class RemoveContactMethodFromNotification < ActiveRecord::Migration
  def change
    remove_column :notifications, :contact_method_id
  end
end
