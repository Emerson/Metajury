require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = FactoryGirl.build(:user)
  end

  test "create" do
    assert_difference "User.count" do
      post :create, {:user => {:email => @user.email, :password => 'password', :username => @user.username}}
      assert_response :success
      assert_template 'registration_steps'
    end
  end

  test "failed create" do
    assert_no_difference "User.count" do
      post :create
      assert_response :success
      assert_template 'signup'
    end
  end

  test "test update" do
    @update_user = FactoryGirl.create(:user)
    session[:user_id] = @update_user.id
    put :update, :id => @update_user.id, :user => {:email => 'update@gmail.com'}
    @update_user.reload
    assert_response :redirect
    assert_redirected_to account_path
    assert @update_user.email == 'update@gmail.com', @update_user.email
  end

  test "failed update" do
    @update_user = FactoryGirl.create(:user)
    session[:user_id] = @update_user.id
    put :update, :id => @update_user.id, :user => {:email => 'aldjghaljgha', :username  => ''}
    assert_response :success
    puts response.body
    assert_template 'edit'
  end

  test 'edit' do
    @edit_user = FactoryGirl.create(:user)
    session[:user_id] = @edit_user.id
    get :edit, :id => @user.id
    puts response.body.inspect
    assert_response :success
    assert_template 'edit'
  end

end
