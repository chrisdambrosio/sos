class LogEntry < ActiveRecord::Base
  belongs_to :alert
  belongs_to :subjectable, polymorphic: true
  belongs_to :objectable,  polymorphic: true
end
