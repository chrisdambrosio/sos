class ScheduleLayerSerializer < ActiveModel::Serializer
  attributes :rotation_duration, :start_time, :priority, :name
  has_many :user_schedules, key: :users
  has_many :schedule_entries, key: :rendered_schedule_entries

  def include_schedule_entries?
    schedule_entries
  end
end
