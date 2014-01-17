class InboxController < ApplicationController
  layout "inbox_layout"
  before_filter :authenticate_user!

  def show
  end

end
