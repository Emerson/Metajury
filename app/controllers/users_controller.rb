class UsersController < ApplicationController


  def new
    @user = User.new
  end


  def create
    @user = User.new(params[:user])
    @user.user_level = 'user'
    if @user.save
      UserMailer.confirmation_email(@user).deliver
      render 'registration_steps'
    else
      render 'signup'
    end
  end


  def update
    @user = current_user
    # Ensure that users have not tried to alter their user_level
    params[:user][:user_level] = 'user' unless @user.admin? || params[:user].blank?
    if @user.update_attributes(params[:user])
      flash[:success] = "Your account has been updated"
      redirect_to account_path
      return
    else
      render 'edit'
    end
  end


  def edit
    @user = current_user
    if params[:id] && params[:id] != @user.id
      flash[:error] = 'There was an error trying to edit that user'
      redirect_to root_path
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


  # Possible exploit. Any user could potentially spam confirmation emails
  # and cripple someones account
  def reconfirm
    @user = User.find(params[:id])
    if @user && !@user.confirmed?
      @user.reconfirm!
      UserMailer.confirmation_email(@user).deliver
    else
      redirect_to root_path, :notice => 'That user is already confirmed'
    end
  end


  # Presents the user with the password reset form
  def request_password_reset
  end


  def send_password_reset
    @user = User.find_by_email(params[:email])
    if @user
      @user.request_password_reset
      UserMailer.password_reset_request(@user).deliver
      flash[:success] = "An email has been sent to #{@user.email} with information about how to reset their password"
      redirect_to root_path
      return
    end
    flash.now[:alert] = 'That email is not registered'
    render 'request_password_reset'
  end


  def update_password
    if request.post? && !params[:reset_token].blank?
      @user = User.find_by_reset_token(params[:reset_token])
      if @user && @user.update_attributes(:password => params[:password])
        flash[:success] = "Your password has been set and you may now login"
        redirect_to login_path
        return
      else
        flash[:alert] = 'There was an error trying to update your password'
        redirect_to root_path
        return
      end
    else
      # Standard get request
      @user = User.find_by_reset_token(params[:token])
      if @user.blank?
        flash[:alert] = "That token seems to be invalid"
        redirect_to root_path
      end
    end
  end

end