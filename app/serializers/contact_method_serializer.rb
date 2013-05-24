class ContactMethodSerializer < ActiveModel::Serializer
  attributes :id, :label, :address, :type_id, :user_id
end
