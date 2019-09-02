class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, :first_name, :last_name, :phone_number, require: true

  has_secure_password
end
