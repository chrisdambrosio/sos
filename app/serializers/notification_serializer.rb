class NotificationSerializer < ActiveModel::Serializer
  attributes :address, :type, :status

  def type
    object.contact_type
  end
end
