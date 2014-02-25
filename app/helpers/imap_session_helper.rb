module ImapSessionHelper
  def new(email_account)
    imap = create

    connect(imap, email_account)

    imap
  end

  def create
    imap = Net::IMAP.new('imap.gmail.com', 993, usessl=true, certs=nil, verify=false)

    imap
  end

  def connect(imap, email_account)
    imap.login(email_account, ENV['PASSWORD'])
  end

  def disconnect(imap)
    imap.logout()
  end
end