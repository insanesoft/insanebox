class InboxController < ApplicationController
  layout "inbox_layout"
  before_filter :authenticate_user!

  def show
    @mails = current_user.fetch_mails
  end

end
