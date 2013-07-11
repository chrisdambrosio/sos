class ScheduleEntry < TimelineEntry
  attr_accessor :user
  def initialize(start_time, end_time, options={})
    @user = options[:user]
    super(start_time, end_time)
  end
end
