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
    if @user.update_attributes(params[:user])
      if @user.confirmed == true
        @user.update_attributes({:token => nil})
      end
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


  def confirm_delete
    @user = User.find(params[:id])
  end


  def destroy
    @user = User.find(params[:id])
    puts @current_user.inspect
    if @current_user.can_update?(@user)
      @user.destroy
      flash[:success] = "User successfully deleted"
      redirect_to admin_root_path
    else
      flash[:alert] = "You do not the rights to delete that user"
      redirect_to admin_root_path
      return
    end
  end

end