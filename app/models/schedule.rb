class Schedule < ActiveRecord::Base
  has_many :schedule_layers
  validates :name, presence: true
  validates :priority, presence: true
  attr_accessor :schedule_entries
  attr_accessor :since
  attr_accessor :until

  def schedule_layers
    layers = super.order(:priority)
    if @since && @until
      layers.each do |layer|
        layer.schedule_entries =
          layer.timeline_entries(@since, @until)
      end
    end
    layers
  end

  def schedule_entries
    return unless @since && @until
    timeline_entries(self.since, self.until)
  end

  def timeline_entries(start_time, end_time)
    timeline = Timeline.new(start_time, end_time)
    schedule_layers.each do |layer|
      timeline.add_timeline_entries(
        layer.timeline_entries(start_time, end_time)
      )
    end
    timeline.timeline_entries
  end
end
