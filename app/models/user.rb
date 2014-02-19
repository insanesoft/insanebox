class User
  require 'gmail_xoauth'
  require 'base64'

  include Mongoid::Document

  field :provider, type:  String
  field :uid, type:  String
  field :token, type:  String
  field :email, type: String
  field :name, type: String
  field :avatar, type: String


  #field :password, type: String

  #validates_confirmation_of :password
  #validates :password, confirmation: true
  validates :email, presence: true, uniqueness: true

  #before_save :encrypt_password

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
        user.avatar = auth['info']['image'] || ""
      end
      debugger
      if auth['credentials']
        debugger
        user.token = auth['credentials']['token'] || ""
      end
    end
  end

  def fetch_mails
    imap = connect(self.email)
    messages_count = imap.status('INBOX', ['MESSAGES'])['MESSAGES']
  end

  def connect(gmail_account)
    imap = Net::IMAP.new('imap.gmail.com', 993, usessl=true, certs=nil, verify=false)
    #imap.authenticate('XOAUTH2', gmail_account, self.token)
    imap.login(gmail_account, ENV['PASSWORD'])

    imap
  end

end
