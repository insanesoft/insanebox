module InboxHelper
  include ImapSessionHelper
  def fetch_mails_by_date(since)
    imap = new(current_user.email)
    #messages_count = imap.status('INBOX', ['MESSAGES'])['MESSAGES']

    imap.examine('INBOX')

    mails = Array.new

    imap.search(["SINCE", since]).slice(0, 10).each do |message_id|
      envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
      mails << [envelope.from.first.name, envelope.date, envelope.subject]
    end

    disconnect(imap)
    mails
  end

  def fetch_mails_by_folder(folder)
    imap = new(current_user.email)
    #messages_count = imap.status('INBOX', ['MESSAGES'])['MESSAGES']

    imap.examine(folder)

    mails = Array.new

    imap.search(["NEW"], charset = 'UTF-8').slice(0, 10).each do |message_id|
      envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
      mails << [envelope.from.first.name, envelope.date, envelope.subject]
    end

    disconnect(imap)
    mails
  end

  def fetch_root_folders
    imap = new(current_user.email)

    folders_struct = imap.list("","*")

    @folder = Array.new

    folders_struct.each do |folder|
      puts "#{folder.name unless folder.name.include?(folder.delim)}"
      @folder << folder.name unless folder.name.include?(folder.delim)
    end
  end
end
