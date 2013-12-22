class SessionsController < ApplicationController

  def new
  end

  #def create
  #  user = User.find_by_email(params[:email])
  #  #debugger
  #  if user && user.authenticate(params[:password] )
  #      session[:user_id] = user.id
  #      redirect_to :controller => "inbox", :action => "show"
  #  else
  #    flash[:notice] = "Email or password is invalid"
  #    render :template => 'home/index'
  #  end
  #end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
