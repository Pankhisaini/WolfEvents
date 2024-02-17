class SessionsController < ApplicationController
  skip_before_action :authorized,only: [:new, :create]
  def new
    if logged_in?
      reset_session
    end
  end

  def create
    puts "DONEEE 1"
    user = User.find_by(email: params[:email])
    puts (user)
    puts "HEHHEHEHE"
    if user && user.authenticate(params[:password])
      puts "DONEEE 3"
      session[:user_id] = user.id
      puts "DONEEE 4"
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
