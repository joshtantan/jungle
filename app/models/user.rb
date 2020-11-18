class User < ActiveRecord::Base
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!
    user = User.find_by_email email
    if !user
      return nil
    end

    if !user.authenticate password
      return nil
    end

    return user
  end

  validates :email, uniqueness: true
  validates :password, length: { in: 6..20 }
end
