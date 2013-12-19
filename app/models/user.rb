class User
  include Mongoid::Document
  field :email, type: String
  field :password, type: String

  validates_confirmation_of :password
  validates :password, confirmation: true
  validates :email, presence: true, uniqueness: true

  before_save :encrypt_password

  def encrypt_method(password)
    Digest::SHA512.hexdigest(password)
  end

  def encrypt_password
    self.password = encrypt_method(self.password)
  end

  def authenticate(password)
    auth = false
    password_encrypted = encrypt_method(password)
    if self.password == password_encrypted
      auth = true
    end
    return auth
  end
end
