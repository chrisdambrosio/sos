class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :name, :time_zone
  has_many :schedule_layers
end
