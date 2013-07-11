class UserSchedule < ActiveRecord::Base
  belongs_to :user
  belongs_to :schedule_layer
  validates :position, presence: true
  validates :user, presence: true

  def start_time
    schedule_layer.start_time + offset
  end

  def end_time
    schedule_layer.end_time
  end

  def timeline_entries(start_time, end_time)
    timeline = Timeline.new(start_time, end_time)
    start_time -= rotation_duration
    rotation_schedule.occurrences_between(start_time, end_time).each do |o|
      timeline.add_timeline_entry(TimelineEntry.new(
        o.start_time, o.start_time + rotation_duration
      ))
    end
    timeline.timeline_entries
  end

  private

  def offset
    rotation_duration * position
  end

  def rotation_duration
    schedule_layer.rotation_duration
  end

  def rotation_interval
    schedule_layer.rotation_interval
  end

  def rotation_schedule
    sched = IceCube::Schedule.new(start_time)
    rrule = IceCube::Rule.secondly(rotation_interval * rotation_duration)
    sched.add_recurrence_rule(rrule)
    sched
  end
end
