class Alert < ActiveRecord::Base
  belongs_to :assigned_to, class_name: 'User', foreign_key: :assigned_to
  has_many :notifications
  has_many :log_entries
  validates :description, presence: true
  validates :assigned_to, presence: true
  default_scope -> { order(created_at: :desc) }
  scope :assigned, -> { where(status: 'assigned') }
  scope :opened_status, -> { where.not(status: 'resolved') }
  after_save :after_save_hook
  after_create :after_create_hook
  attr_accessor :agent
  attr_accessor :channel

  state_machine :status, :initial => :triggered do
    after_transition :log_status_change, :on => all - [:triggered]
    state :triggered,     value: 0
    state :acknowledged,  value: 1
    state :resolved,      value: 2

    event :acknowledged do
      transition :triggered => :acknowledged
    end

    event :resolved do
      transition [:triggered, :acknowledged] => :resolved
    end

    state :triggered do
      def action_name
        :trigger
      end
    end
    state :acknowledged do
      def action_name
        :acknowledge
      end
    end
    state :resolved do
      def action_name
        :resolve
      end
    end
  end

  private

  def after_create_hook
    log_status_change
  end

  def after_save_hook
    if assigned_to_changed?
      log_assigned_to_change
      notify_user
    end
  end

  def log_status_change
    LogEntry.create(
      alert: self, action: action_name, channel: channel.to_json, agent: agent
    )
  end

  def log_assigned_to_change
    LogEntry.create(
      alert: self, action: 'assign', channel: channel.to_json,
      agent: agent, user: assigned_to
    )
  end

  def notify_user
    assigned_to.notification_rules.each do |rule|
      Notification.create(
        contact_method: rule.contact_method,
        send_at: Time.now + rule.start_delay.minutes,
        alert: self
      )
    end
  end
end
