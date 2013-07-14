class UserScheduleSerializer < ActiveModel::Serializer
  attributes :position
  has_one :user
end
