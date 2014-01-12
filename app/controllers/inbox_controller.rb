class InboxController < ApplicationController
  layout "inbox_layout"
  before_filter :authorize
  def show
  end
end
