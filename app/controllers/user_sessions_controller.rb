class UserSessionsController < ApplicationController


  def login
    session[:user_id] = nil

    if request.post? # If the user is trying to login

      if params[:email].blank? or params[:password].blank?
        flash.now[:alert] = 'There was a problem with your email or password'
        return
      end

      @user = User.find_by_email(params[:email])
      if !@user.blank? and !@user.confirmed?
        render 'reconfirm'
        return
      end

      # Refactor the login method to account for unconfirmed users
      # at the moment it just returns the user, or false. We need
      # a method of indicating the reason why the login failed
      @user = User.login(params[:email], params[:password])
      logger.info params.inspect
      if @user
        session[:user_id] = @user.id
        flash[:success] = 'You have been logged in'
        Feed.login_user(@user)
        if @user.admin?
          redirect_to admin_root_path
        else
          redirect_to root_path
        end
      else
        flash.now[:alert] = 'There was a problem with your email or password'
        render 'login'
      end

    end # request.post? ends here

  end


  def logout
    Feed.logout_user(@current_user) if @current_user
    session[:user_id] = nil
    session[:success] = 'You have been logged out'
    redirect_to root_path
  end


end