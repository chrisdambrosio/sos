class NotificationRuleSerializer < ActiveModel::Serializer
  attributes :id, :contact_method_id, :start_delay
end
