class User
  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :email, type: String
  field :password, type: String

  attr_protected :provider, :uid, :name, :email
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

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
        user.name = auth['info']['name'] || ""
        user.email = auth['info']['email'] || ""
      end
    end
  end

end
