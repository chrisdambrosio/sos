class AddAgentAndChannelToLogEntry < ActiveRecord::Migration
  def change
    add_column :log_entries, :agent, :json
    add_column :log_entries, :channel, :json
  end
end
