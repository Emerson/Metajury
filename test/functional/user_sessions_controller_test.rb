require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase

  def setup
    @user = FactoryGirl.create(:valid_user)
    @admin_user = FactoryGirl.create(:admin)
  end 

  test "login" do
    post :login, :email => @user.email, :password => 'password'
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal @user.id, @controller.session[:user_id]
  end

  test "admin login" do
    post :login, :email => @admin_user.email, :password => 'password'
    assert_response :redirect
    assert_redirected_to admin_root_path
    assert_equal @admin_user.id, @controller.session[:user_id]
  end

  test "blank params" do
    post :login
    assert_response :success
    assert flash.now[:alert] = "There was a problem with your email or password"
  end

  test "unconfirmed user" do
    @user.update_attribute(:confirmed, false)
    post :login, :email => @user.email, :password => 'password'
    assert_response :success
    assert_template 'reconfirm'
  end

  test "failed login" do
    post :login, :email => 'failed@email.com', :password => 'nopassword'
    assert_response :success
    assert_template 'login'
    assert flash.now[:alert] = "There was a problem with your email or password"
  end

  test "logout" do
    session[:user_id] = @user.id
    get :logout
    assert_response :redirect
    assert_redirected_to root_path
  end

end
