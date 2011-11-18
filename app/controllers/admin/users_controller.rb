class Admin::UsersController < ApplicationController


  layout 'admin'


  def index
    @users = User.all
  end


  def new
    @user = User.new
  end


  def edit
    @user = User.find(params[:id])
  end


  def update
    @user = User.find_by_id(params[:id])
    if @user.user_level = 'super-admin'
      params[:user][:user_level] = 'super-admin'
    end
    if @user.update_attributes(params[:user])
      flash[:success] = "Account has been updated"
      redirect_to edit_admin_user_path(@user)
    else
      render 'edit'
    end
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