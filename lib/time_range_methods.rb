module TimeRangeMethods
  def start_time
    @start_time
  end

  def end_time
    @end_time
  end

  def duration
    end_time - start_time
  end
end
