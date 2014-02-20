class InboxController < ApplicationController
  layout "inbox_layout"
  before_filter :authenticate_user!

  def show
    since = Time.now
    @mails = current_user.fetch_mails_by_date("19-feb-2014")
    @folders = current_user.fetch_root_folders
    debugger
  end

  def getFolder

  end

end
