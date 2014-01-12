class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    #debugger
    if user && user.authenticate(params[:password] )
        session[:user_id] = user.id
        redirect_to :controller => "inbox", :action => "show"
    else
      flash[:notice] = "Email or password is invalid"
      render :template => 'home/index'
    end
  end

  def destroy

  end
end
