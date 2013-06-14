class ContactMethod < ActiveRecord::Base
  has_many :notification_rules
  belongs_to :user
  TYPES = { 0 => :sms, 1 => :phone, 2 => :email }

  def type
    TYPES[type_id]
  end
end
