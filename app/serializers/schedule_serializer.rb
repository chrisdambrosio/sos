class ScheduleSerializer < ActiveModel::Serializer
  attributes :name, :time_zone
  has_many :schedule_layers
end
