class ChangeAgentOnLogEntries < ActiveRecord::Migration
  def change
    add_column :log_entries, :agent_id, :integer
    add_column :log_entries, :agent_type, :string
    remove_column :log_entries, :agent
  end
end
