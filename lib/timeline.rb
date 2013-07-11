class Timeline
  include TimeRangeMethods

  def initialize(start_time, end_time, options={})
    @timeline_entries = Array.new
    @start_time = start_time
    @end_time = end_time
  end

  def add_timeline_entry(timeline_entry)
    vacancies = vacancies_during(timeline_entry)
    vacancies.each do |vacancy|
      @timeline_entries << timeline_entry.constrain_within(vacancy)
    end
    timeline_entries
  end

  def add_timeline_entries(*entries)
    entries.flatten.each do |entry|
      add_timeline_entry(entry)
    end
    timeline_entries
  end

  def timeline_entries
    @timeline_entries.sort_by! { |e| e.start_time }
  end

  def vacancies
    vacancies = Array.new
    if @timeline_entries.empty?
      vacancies << TimelineEntry.new(start_time, end_time)
    end
    if @timeline_entries.count > 0
        vacancies << TimelineEntry.new(start_time, @timeline_entries.first.start_time)
        vacancies << TimelineEntry.new(@timeline_entries.last.end_time, end_time)
    end
    if vacancies.count > 1
      @timeline_entries.each_with_index do |entry,i|
        if @timeline_entries[i+1]
          vacancies << TimelineEntry.new(entry.end_time, @timeline_entries[i+1].start_time)
        end
      end
    end
    vacancies.select { |v| v.duration > 0 }.sort_by { |v| v.start_time }
  end

  def merge_overlapping_entries(timeline_entries)
    *new_entries = timeline_entries.shift
    timeline_entries.each do |entry|
      prev_entry = new_entries[-1]
      if prev_entry.end_time == entry.start_time
        new_entries[-1] = prev_entry.merge(entry)
      else
        new_entries.push(entry)
      end
    end
    new_entries
  end

  private

  def vacancies_during(timeline_entry)
    vacancies.find_all { |vacancy| vacancy.overlaps_with?(timeline_entry) }
  end
end
