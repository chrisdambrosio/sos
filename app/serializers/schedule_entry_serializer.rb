class ScheduleEntrySerializer < ActiveModel::Serializer
  attributes :start_time, :end_time
  has_one :user
end
