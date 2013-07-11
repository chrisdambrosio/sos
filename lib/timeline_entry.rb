class TimelineEntry
  include TimeRangeMethods

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
  end

  def overlaps_with?(timeline_entry)
    if (start_time >= timeline_entry.end_time) ||
       (end_time <= timeline_entry.start_time)
      false
    else
      true
    end
  end

  def constrain_within(constraint)
    tl_entry = self.clone
    if start_time < constraint.start_time
      tl_entry.instance_variable_set('@start_time', constraint.start_time)
      tl_entry.instance_variable_set('@end_time', tl_entry.end_time)
    end
    if end_time > constraint.end_time
      tl_entry.instance_variable_set('@start_time', tl_entry.start_time)
      tl_entry.instance_variable_set('@end_time', constraint.end_time)
    end
    tl_entry
  end

  def merge(timeline_entry)
    start_time = [timeline_entry.start_time, self.start_time].min
    end_time = [timeline_entry.end_time, self.end_time].max
    TimelineEntry.new(start_time, end_time)
  end

  def restriction?
    false
  end
end
