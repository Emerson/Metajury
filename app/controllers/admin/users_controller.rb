class Admin::UsersController < ApplicationController


  layout 'admin'


  def index
    @users = User.all
  end


  def new
    @user = User.new
  end


  def create
    @user = User.create(params[:user])
    if @user.save
      if params[:user][:send_password]
        UserMailer.send_password(@user, params[:user][:password]).deliver
      end
      redirect_to admin_users_path, :success => 'New user has been successfully added'
    else
      render 'new'
    end
  end


end