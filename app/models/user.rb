class User < ActiveRecord::Base
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }

  before_save :clean_email, :check_password

  def clean_email
    self.email = self.email.strip.downcase 
  end
  
  def check_password
    if self.password != self.password_confirmation
      errors.add(:password, "Password confirmation doesn't match")
    end
  end

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else 
      nil
    end
  end
end
