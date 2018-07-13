class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password]) == user
      session[:user_id] = user.id
      flash[:notice] = "You are logged in"
      redirect_to root_path
    else
      flash[:error] = 'Theres something wrong with username or password'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to root_path
  end
end
