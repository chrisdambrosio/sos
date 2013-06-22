class Alert < ActiveRecord::Base
  belongs_to :assigned_to, class_name: 'User', foreign_key: :assigned_to
  validates :description, presence: true
end
