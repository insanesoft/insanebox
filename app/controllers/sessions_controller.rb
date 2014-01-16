class SessionsController < ApplicationController

  def new
    redirect_to '/auth/google_oauth2'
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
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to :controller => "inbox", :action => "show", :notice => "Signed in!"
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
