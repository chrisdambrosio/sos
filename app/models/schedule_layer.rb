class ScheduleLayer < ActiveRecord::Base
  belongs_to :schedule
  has_many :user_schedules
  has_many :restrictions
  validates :start_time, presence: true
  validates :rotation_duration, presence: true
  validates :position, presence: true
  attr_accessor :schedule_entries

  def user_schedules
    super.order(:position)
  end

  def rotation_interval
    user_schedules.count
  end

  def timeline_entries(start_time, end_time)
    timeline = Timeline.new(start_time, end_time)
    add_restrictions_to(timeline)
    user_schedules.each do |user_schedule|
      timeline.add_timeline_entries(
        user_schedule.timeline_entries(start_time, end_time)
      )
    end
    timeline.timeline_entries.reject { |e| e.restriction? }
  end

  private

  def add_restrictions_to(timeline)
    restrictions.each do |restriction|
      restriction_entries =
        restriction.restriction_entries(timeline.start_time, timeline.end_time)
      timeline.add_timeline_entries(restriction_entries)
    end
  end
end
