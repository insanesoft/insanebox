class InboxController < ApplicationController
  include InboxHelper
  layout "inbox_layout"
  before_filter :authenticate_user!

  def show
    since = Time.now
    @mails = fetch_mails_by_folder("INBOX")
    @folders = fetch_root_folders
  end
end
