class Notification < ActiveRecord::Base
  belongs_to :contact_method
  belongs_to :alert
  validates :contact_method, presence: true
  validates :alert, presence: true
end
