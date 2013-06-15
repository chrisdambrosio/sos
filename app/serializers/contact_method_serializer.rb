class ContactMethodSerializer < ActiveModel::Serializer
  attributes :id, :label, :address, :type, :user_id
end
