class UsersController < ApplicationController


  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.confirmation_email(@user).deliver
      render 'registration_steps'
    else
      render 'signup'
    end
  end


  # Non-Restful Routes


  def confirm
    @user = User.find_by_token(params[:token])
    if @user
      UserMailer.confirmation_complete_email(@user).deliver
      @user.confirm!
    else
      redirect_to root_path, :notice => 'That token seems to be invalid'
    end
  end


  def signup
    unless ApplicationSettings.config['user_registration']
      redirect_to root_path
      return
    end
    @user = User.new
  end


end