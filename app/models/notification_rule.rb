class NotificationRule < ActiveRecord::Base
  belongs_to :contact_method
  has_one :user, through: :contact_method
end
