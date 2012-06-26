require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = FactoryGirl.create(:valid_user)
    @comment = @user.comments << FactoryGirl.build(:valid_comment)
    @comment = @comment.first
  end

  test "validity" do
    assert @comment.valid?
  end

end
