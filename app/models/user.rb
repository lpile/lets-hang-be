class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, :first_name, :last_name, :phone_number, require: true

  has_secure_password
end
