class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Cat'

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'CatRentalRequest'

  def self.find_by_credentials(user_name, password)
    # returns the user with the given name if the password is correct.
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def generate_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save
    self.session_token
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
     self.generate_session_token if self.session_token.nil?
  end

end
