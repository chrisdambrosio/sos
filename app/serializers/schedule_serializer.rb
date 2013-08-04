class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :name, :time_zone, :final_schedule
  has_many :schedule_layers

  def include_final_schedule?
    object.schedule_entries
  end

  def final_schedule
    { name: 'Final Schedule',
      rendered_schedule_entries: object.schedule_entries.map { |e|
        ScheduleEntrySerializer.new(e, root: false).as_json }
    }
  end
end
