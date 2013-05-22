class Alert < ActiveRecord::Base
  validates :description, presence: true
end
