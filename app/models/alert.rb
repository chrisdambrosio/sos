class Alert < ActiveRecord::Base
  belongs_to :assigned_to, class_name: 'User', foreign_key: :assigned_to
  has_many :notifications
  has_many :log_entries
  validates :description, presence: true
  validates :assigned_to, presence: true
  scope :assigned, -> { where status: 'assigned' }

  after_create :after_create_hook

  private

  def after_create_hook
    update_attributes(status: 'assigned')
    assigned_to.notification_rules.each do |rule|
      Notification.create(
        contact_method: rule.contact_method,
        send_at: Time.now + rule.start_delay.minutes,
        alert: self
      )
    end
  end
end
