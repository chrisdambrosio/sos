class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :alerts, foreign_key: :assigned_to
  has_many :contact_methods
  has_many :notification_rules, through: :contact_methods
  has_many :log_entries, as: :subjectable
  validates :email, presence: true
  validates :name, presence: true
end
