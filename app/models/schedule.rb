class Schedule < ActiveRecord::Base
  has_many :schedule_layers
  validates :name, presence: true
end
