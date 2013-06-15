class ContactMethod < ActiveRecord::Base
  has_many :notification_rules
  belongs_to :user
  TYPES = { 0 => :sms, 1 => :phone, 2 => :email }

  def type
    TYPES[type_id]
  end

  def type=(type)
    type_id = TYPES.find {|k,v| v == type.to_sym}
    self.type_id = type_id[0] if type_id
  end
end
