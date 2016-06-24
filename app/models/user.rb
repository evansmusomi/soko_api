class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Hooks
  before_create :generate_authentication_token!

  # Validations
  validates :email, uniqueness: {case_sensitive: false}
  validates :auth_token, uniqueness: {case_sensitive: false}

  # Generate unique authentication token
  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
