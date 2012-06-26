require 'test_helper'

class CommentsControllerTest < ActionController::TestCase

  def setup
    @fixture_user = FactoryGirl.create(:valid_user)
    @fixture_submission = FactoryGirl.create(:valid_submission)
    @fixture_comment = @fixture_user.comments << FactoryGirl.build(:valid_comment, :submission_id => @fixture_submission.id)
    @fixture_comment = @fixture_comment.first
  end

  test 'index when logged out' do
    get :index, :submission_id => @fixture_submission.id
    assert_response :success
    assert assigns(:submission)
    assert assigns(:comments)
  end

  test 'index when logged in' do
    session[:user_id] = @fixture_user.id
    get :index, :submission_id => @fixture_submission.id
    assert_response :success
    assert assigns(:submission)
    assert assigns(:comment)
    assert assigns(:comments)
  end

  test 'create when logged in' do
    session[:user_id] = @fixture_user.id
    post :create, :submission_id => @fixture_submission.id, :comment => {
      :content => 'test create comment'
    }
    assert assigns(:submission)
    assert assigns(:comment)
    assert_present flash[:success]
    assert_redirected_to submission_comments_path(@fixture_submission)
  end

  test 'create when logged out' do 
    post :create, :submission_id => @fixture_submission.id, :comment => {
      :content => 'logged out create test'
    }
    assert_present flash[:error]
    assert_redirected_to root_path
  end

  test 'failed create' do
    session[:user_id] = @fixture_user.id
    post :create, :submission_id => @fixture_submission.id, :comment => {}
    assert_response :redirect
    assert_present flash[:error]
    assert_redirected_to submission_comments_path(@fixture_submission.id)
  end
end
