class ScheduleLayer < ActiveRecord::Base
  has_many :user_schedules
  validates :start_time, presence: true
  validates :rotation_duration, presence: true

  def rotation_interval
    user_schedules.count
  end

  def timeline_entries(start_time, end_time)
    timeline = Timeline.new(start_time, end_time)
    #add_restrictions_to(timeline)
    user_schedules.each do |user_schedule|
      timeline.add_timeline_entries(
        user_schedule.timeline_entries(start_time, end_time)
      )
    end
    timeline.timeline_entries#.reject { |e| e.restriction? }
  end
end
