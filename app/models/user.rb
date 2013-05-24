class User < ActiveRecord::Base
  has_many :contact_methods
  validates :email, presence: true
  validates :name, presence: true
end
