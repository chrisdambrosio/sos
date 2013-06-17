class ContactMethod < ActiveRecord::Base
  has_many :notification_rules
  belongs_to :user
  CONTACT_TYPES = { 0 => :sms, 1 => :phone, 2 => :email }

  def contact_type
    CONTACT_TYPES[type_id]
  end

  def contact_type=(contact_type)
    type_id = CONTACT_TYPES.find {|k,v| v == contact_type.to_sym}
    self.type_id = type_id[0] if type_id
  end
end
