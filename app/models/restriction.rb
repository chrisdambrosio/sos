class Restriction < ActiveRecord::Base
  belongs_to :schedule_layer
  validates :start_time_of_day, presence: true
  validates :end_time_of_day, presence: true

  def start_day_of_week=(day)
    day = Time::DAYS_INTO_WEEK[day.to_sym.downcase] if day
    self[:start_day_of_week] = day
  end

  def end_day_of_week=(day)
    day = Time::DAYS_INTO_WEEK[day.to_sym.downcase] if day
    self[:end_day_of_week] = day
  end

  def start_time_of_day=(time)
    self[:start_time_of_day] = TimeOfDay.parse(time).second_of_day if time
  end

  def start_time_of_day
    TimeOfDay.new(0) + self[:start_time_of_day] if self[:start_time_of_day]
  end

  def end_time_of_day=(time)
    self[:end_time_of_day] = TimeOfDay.parse(time).second_of_day if time
  end

  def end_time_of_day
    TimeOfDay.new(0) + self[:end_time_of_day] if self[:end_time_of_day]
  end

  def restriction_type
    if start_day_of_week && end_day_of_week
      :week
    else
      :day
    end
  end

  def timeline_entries(start_time, end_time)
    timeline = Timeline.new(start_time, end_time)
    occurrences_between(start_time, end_time).each do |o|
      start_date = o.to_date + (start_day_of_week || 0)
      timeline.add_timeline_entry(
        TimelineEntry.new(
          start_date.at(start_time_of_day),
          start_date.at(start_time_of_day) + duration,
        )
      )
    end
    timeline.timeline_entries
  end

  def restriction_entries(start_time, end_time)
    timeline = Timeline.new(start_time, end_time)
    timeline.add_timeline_entries(timeline_entries(start_time, end_time))
    timeline.vacancies.map do |v|
      RestrictionEntry.new(v.start_time, v.end_time)
    end
  end

  private

  def duration
    difference_of_days_of_week.days + difference_of_times_of_day
  end

  def difference_of_days_of_week
    case restriction_type
    when :week
      ((end_day_of_week + 1) - (start_day_of_week + 1)) % 7
    when :day
      0
    end
  end

  def difference_of_times_of_day
    end_time_of_day.second_of_day - start_time_of_day.second_of_day
  end

  def occurrences_between(start_time, end_time)
    units = Array.new
    unit = start_time.send("beginning_of_#{restriction_type}") - 1.send(restriction_type)
    loop do
      break if unit > end_time
      units << unit
      unit += 1.send(restriction_type.to_sym)
    end
    units
  end
end
