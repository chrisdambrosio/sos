class ScheduleEntry < TimelineEntry
  include ActiveModel::Conversion
  include ActiveModel::Naming
  include ActiveModel::Serialization
  attr_accessor :user
  attr_reader :start_time, :end_time, :attributes
  def initialize(start_time, end_time, options={})
    @user = options[:user]
    super(start_time, end_time)
  end

  def attributes
    { user: @user, start_time: @start_time, end_time: @end_time }
  end

  def persisted?
    false
  end

  def active_model_serializer
    ScheduleEntrySerializer
  end
end
