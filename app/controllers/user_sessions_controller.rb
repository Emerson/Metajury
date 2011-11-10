class UserSessionsController < ApplicationController


  def login
    if params[:email].blank? or params[:password].blank?
      flash[:alert] = 'There was a problem with your email or password'
      redirect_to root_path
      return
    end
    @user = User.login(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      flash[:success] = 'You have been logged in'
      redirect_to root_path
    else
      flash.now[:alert] = 'There was a problem with your email or password'
    end
  end


  def logout
    session[:user_id] = nil
    session[:success] = 'You have been logged out'
    redirect_to root_path
  end


end