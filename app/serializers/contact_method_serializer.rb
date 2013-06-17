class ContactMethodSerializer < ActiveModel::Serializer
  attributes :id, :label, :address, :contact_type, :user_id
end
