class User < ActiveRecord::Base
  has_many :alerts, foreign_key: :assigned_to
  has_many :contact_methods
  has_many :notification_rules, through: :contact_methods
  validates :email, presence: true
  validates :name, presence: true
end
