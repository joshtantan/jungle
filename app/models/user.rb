class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true
  validates :password, length: { in: 6..20 }
end
