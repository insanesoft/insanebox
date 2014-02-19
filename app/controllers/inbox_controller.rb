class InboxController < ApplicationController
  layout "inbox_layout"
  before_filter :authenticate_user!

  def show
    from = "1-feb-2014"
    to = "19-feb-2014"
    @mails = current_user.fetch_mails_by_date(from, to)
    current_user.fetch_root_folders
  end

end
