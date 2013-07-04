class LogEntry < ActiveRecord::Base
  belongs_to :alert
  belongs_to :notification
  belongs_to :agent, polymorphic: true
  belongs_to :user
end
