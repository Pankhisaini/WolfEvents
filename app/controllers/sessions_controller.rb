class SessionsController < ApplicationController
  skip_before_action :authorized,only: [:new, :create]
  def new
    if logged_in?
      reset_session
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice:'Logged in Successfully'
    else
      flash.now[:alert] = "Email or password is invalid"
      redirect_to login_path
    end
  end


  def destroy
    session[:user_id]=nil
    redirect_to root_url
  end
end
