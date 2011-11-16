class Admin::UsersController < ApplicationController

  layout 'admin'

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

end